<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BoltClaim - Premium Flash Sales</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-color: #000;
                color: #fff;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .navbar {
                padding: 1rem 2rem;
                border-bottom: 1px solid #222;
            }

            .hero {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                background: radial-gradient(circle at center, #1a1a1a 0%, #000 100%);
            }

            .hero-content {
                max-width: 800px;
                padding: 2rem;
            }

            h1 {
                font-size: 4rem;
                font-weight: 800;
                margin-bottom: 1rem;
                background: linear-gradient(45deg, #fff, #888);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            p.lead {
                color: #888;
                font-size: 1.5rem;
                margin-bottom: 3rem;
            }

            .btn-cta {
                padding: 12px 40px;
                font-size: 1.2rem;
                border-radius: 50px;
                font-weight: 600;
                transition: transform 0.2s;
            }

            .btn-cta:hover {
                transform: scale(1.05);
            }

            .footer {
                padding: 2rem;
                text-align: center;
                border-top: 1px solid #222;
                color: #444;
            }
        </style>
    </head>

    <body>

        <nav class="navbar navbar-expand-lg navbar-dark bg-black">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold text-white" href="#">
                    <i class="bi bi-lightning-fill text-warning me-2"></i>BoltClaim
                </a>
                <div class="d-flex gap-3">
                    <a href="${pageContext.request.contextPath}/login"
                        class="btn btn-outline-light btn-sm px-4 rounded-pill">Login</a>
                    <a href="${pageContext.request.contextPath}/register"
                        class="btn btn-light btn-sm px-4 rounded-pill fw-bold text-dark">Join Now</a>
                </div>
            </div>
        </nav>

        <section class="hero">
            <div class="hero-content">
                <span class="badge bg-warning text-dark mb-4 py-2 px-3 rounded-pill fw-bold">LIVE FLASH SALES</span>
                <h1>Claim Deals in Milliseconds.</h1>
                <p class="lead">The fastest flash sale platform for exclusive drops. Be ready, act fast.</p>
                <div class="d-flex justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/register"
                        class="btn btn-warning btn-cta text-dark border-0">Start Claiming</a>
                    <a href="${pageContext.request.contextPath}/login"
                        class="btn btn-outline-secondary btn-cta text-white">Log In</a>
                </div>

                <div class="mt-5 d-flex justify-content-center gap-5 text-secondary">
                    <div>
                        <i class="bi bi-clock-history fs-4 mb-2 d-block"></i>
                        <small>Real-time</small>
                    </div>
                    <div>
                        <i class="bi bi-shield-lock fs-4 mb-2 d-block"></i>
                        <small>Secure</small>
                    </div>
                    <div>
                        <i class="bi bi-trophy fs-4 mb-2 d-block"></i>
                        <small>Exclusive</small>
                    </div>
                </div>
            </div>
        </section>

        <footer class="footer">
            <small>&copy; 2026 BoltClaim. High frequency commerce.</small>
        </footer>

    </body>

    </html>