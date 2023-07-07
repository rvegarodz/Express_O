package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"

	"github.com/stripe/stripe-go/v72"
	"github.com/stripe/stripe-go/v72/paymentintent"
	"github.com/stripe/stripe-go/v72/webhook"
)

// PaymentIntentSucceededEvent represents the structure of the payment_intent.succeeded event.
type PaymentIntentSucceededEvent struct {
	EventID         string `json:"event_id"`
	PaymentIntentID string `json:"payment_intent_id"`
	AmountReceived  int64  `json:"amount_received"`
	Status          string `json:"status"`
}

var succeededEvents []PaymentIntentSucceededEvent

func main() {
	stripe.Key = os.Getenv("STRIPE_SECRET_KEY")

	stripe.SetAppInfo(&stripe.AppInfo{
		Name:    "stripe-samples/accept-a-payment/payment-element",
		Version: "0.0.1",
		URL:     "https://github.com/stripe-samples",
	})

	http.Handle("/", http.FileServer(http.Dir(os.Getenv("STATIC_DIR"))))
	http.HandleFunc("/config", handleConfig)
	http.HandleFunc("/create-payment-intent", handleCreatePaymentIntent)
	http.HandleFunc("/webhook", handleWebhook)
	http.HandleFunc("/payment-intent-events", handlePaymentIntentEvents)
	http.HandleFunc("/payment-intent-event", handlePaymentIntentEvent)

	log.Println("Server running...")
	err := http.ListenAndServe(":"+os.Getenv("PORT"), enableCors(http.DefaultServeMux))
	if err != nil {
		log.Fatal("Server failed to start: ", err)
	}
}

func enableCors(handler http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		handler.ServeHTTP(w, r)
	})
}

func handleConfig(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
		return
	}

	writeJSON(w, map[string]interface{}{
		"publishableKey": os.Getenv("STRIPE_PUBLISHABLE_KEY"),
	})
}

var clientSecret string
var paymentURL string

func handleCreatePaymentIntent(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		return
	}

	if r.Method == http.MethodGet {
		writeJSON(w, map[string]interface{}{
			"publishableKey": os.Getenv("STRIPE_PUBLISHABLE_KEY"),
			"clientSecret":   clientSecret,
			"paymentURL":     paymentURL,
		})
		return
	}

	if r.Method != http.MethodPost {
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
		return
	}

	var paymentDetails struct {
		Amount   int64  `json:"amount"`
		Currency string `json:"currency"`
	}
	if err := json.NewDecoder(r.Body).Decode(&paymentDetails); err != nil {
		http.Error(w, "Invalid payment details", http.StatusBadRequest)
		return
	}

	params := &stripe.PaymentIntentParams{
		Amount:   stripe.Int64(paymentDetails.Amount),
		Currency: stripe.String(paymentDetails.Currency),
		AutomaticPaymentMethods: &stripe.PaymentIntentAutomaticPaymentMethodsParams{
			Enabled: stripe.Bool(true),
		},
	}

	pi, err := paymentintent.New(params)
	if err != nil {
		http.Error(w, "Failed to create payment intent", http.StatusInternalServerError)
		return
	}

	clientSecret = pi.ClientSecret

	writeJSON(w, map[string]interface{}{
		"paymentIntentID": pi.ID,
		"clientSecret":    pi.ClientSecret,
		"status":          pi.Status,
	})
}

func handleWebhook(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
		return
	}

	const MaxRequestBodySize = 65536 // 64KB
	r.Body = http.MaxBytesReader(w, r.Body, MaxRequestBodySize)

	b, err := ioutil.ReadAll(r.Body)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Printf("ioutil.ReadAll: %v", err)
		return
	}

	event, err := webhook.ConstructEvent(b, r.Header.Get("Stripe-Signature"), os.Getenv("STRIPE_WEBHOOK_SECRET"))
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		log.Printf("webhook.ConstructEvent: %v", err)
		return
	}

	switch event.Type {
	case "payment_intent.created":
		// Handle payment_intent.created event
		fmt.Println("Payment Intent created!")
	case "payment_intent.succeeded":
		// Handle payment_intent.succeeded event
		fmt.Println("Payment Intent succeeded!")

	case "payment_intent.payment_failed":
		// Handle payment_intent.payment_failed event
		fmt.Println("Payment Intent payment failed!")
	default:
		// Handle other webhook events
		fmt.Println("Unhandled event:", event.Type)
	}

	writeJSON(w, nil)
}

func handlePaymentIntentEvents(w http.ResponseWriter, r *http.Request) {
	writeJSON(w, succeededEvents)
}

func handlePaymentIntentEvent(w http.ResponseWriter, r *http.Request) {
	paymentIntentID := r.URL.Query().Get("payment_intent_id")

	for _, event := range succeededEvents {
		if event.PaymentIntentID == paymentIntentID {
			writeJSON(w, event)
			return
		}
	}

	http.NotFound(w, r)
}

func writeJSON(w http.ResponseWriter, v interface{}) {
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(v); err != nil {
		log.Printf("json.NewEncoder.Encode: %v", err)
		http.Error(w, "Internal server error", http.StatusInternalServerError)
	}
}
