package main

import (
        "fmt"
        "log"
        "net/http"
        "os"
        "strings"
)

func enableCors(w *http.ResponseWriter) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
}

func handler(w http.ResponseWriter, r *http.Request) {
        log.Printf("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
        target := os.Getenv("TARGET")
        if target == "" {
                target = "World"
        }

        enableCors(&w)
        
        var request []string
        url := fmt.Sprintf("%v %v %v", r.Method, r.URL, r.Proto)
        request = append(request, url)
        request = append(request, fmt.Sprintf("Host: %v", r.Host))
        for name, headers := range r.Header {
            name = strings.ToLower(name)
            for _, h := range headers {
                request = append(request, fmt.Sprintf("%v: %v", name, h))
            }
        }
        if r.Method == "POST" {
            r.ParseForm()
            request = append(request, "\n")
            request = append(request, r.Form.Encode())
        }

        fmt.Fprintf(w, "Hello %s!\n\nHeaders:\n%s", target, strings.Join(request, "\n"))
}

func main() {
        log.Print("Hello world simpleserver started.")

        http.HandleFunc("/", handler)

        port := os.Getenv("PORT")
        if port == "" {
                port = "8080"
        }

        log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
