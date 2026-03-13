#!/usr/bin/env python3
import http.server
import socketserver
import os
import webbrowser

PORT = 8080
DIRECTORY = "C:\\Users\\Suresh Kumar PR\\Documents\\Divya_Project"

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

try:
    with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
        print(f"Server running at http://localhost:{PORT}")
        print(f"Report available at: http://localhost:{PORT}/karate-summary.html")
        print(f"Your IP: http://192.168.31.186:{PORT}/karate-summary.html")
        print("Press Ctrl+C to stop the server")
        
        # Try to open browser automatically
        try:
            webbrowser.open(f'http://localhost:{PORT}/karate-summary.html')
        except:
            pass
            
        httpd.serve_forever()
except KeyboardInterrupt:
    print("\nServer stopped")
except Exception as e:
    print(f"Error: {e}")
    input("Press Enter to exit...")
