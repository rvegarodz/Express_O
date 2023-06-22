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

func main() {
	stripe.Key = os.Getenv("STRIPE_SECRET_KEY")

	// For sample support and debugging, not required for production:
	stripe.SetAppInfo(&stripe.AppInfo{
		Name:    "stripe-samples/accept-a-payment/payment-element",
		Version: "0.0.1",
		URL:     "https://github.com/stripe-samples",
	})

	http.Handle("/", http.FileServer(http.Dir(os.Getenv("STATIC_DIR"))))
	http.HandleFunc("/config", handleConfig)
	http.HandleFunc("/create-payment-intent", handleCreatePaymentIntent)
	http.HandleFunc("/webhook", handleWebhook)

	log.Println("Server running at http://localhost:4242")
	err = http.ListenAndServe("0.0.0.0:4242", enableCors(http.DefaultServeMux))
	if err != nil {
		log.Fatal("Server failed to start: ", err)
	}
}

// ErrorResponseMessage represents the structure of the error
// object sent in failed responses.
type ErrorResponseMessage struct {
	Message string `json:"message"`
}

// ErrorResponse represents the structure of the error object sent
// in failed responses.
type ErrorResponse struct {
	Error *ErrorResponseMessage `json:"error"`
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

	paymentURL = fmt.Sprintf("https://your-website.com/payments/%s", pi.ID)
	clientSecret = pi.ClientSecret

	writeJSON(w, map[string]interface{}{
		"clientSecret": pi.ClientSecret,
		"paymentURL":   paymentURL,
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

	if event.Type == "checkout.session.completed" {
		fmt.Println("Checkout Session completed!")
	}

	writeJSON(w, nil)
}

func writeJSON(w http.ResponseWriter, v interface{}) {
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(v); err != nil {
		log.Printf("json.NewEncoder.Encode: %v", err)
		http.Error(w, "Internal server error", http.StatusInternalServerError)
	}
}
