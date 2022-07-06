package main

import (
	"log"
	"net/http"
)

func main() {
	log.Print("demo-back-01 is running \n")
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("request: %v, %v, %v, %v%v", r.Proto, r.Method, r.RemoteAddr, r.Host, r.URL)
		w.Write([]byte("hello world\n"))
	})
	err := http.ListenAndServe(":54321", nil)
	if err != nil {
		log.Fatal(err)
	}
}
