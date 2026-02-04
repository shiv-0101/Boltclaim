<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BoltClaim - Flash Sale Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #0a0a0a;
        }
        .hero-section {
            min-height: 100vh;
        }
        .feature-card {
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            transition: border-color 0.2s;
        }
        .feature-card:hover {
            border-color: #ffc107;
        }
        .nav-link-custom {
            color: #888;
        }
        .nav-link-custom:hover {
            color: #fff;
        }
    </style>
</head>
<body class="text-white">

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-transparent position-fixed w-100" style="z-index: 1000;">
        <div class="container py-2">
            <a class="navbar-brand fw-bold" href="/">⚡ BoltClaim</a>
            <div class="d-flex gap-2">
                <a href="/login" class="btn btn-outline-light btn-sm">Login</a>
                <a href="/register" class="btn btn-warning btn-sm text-dark">Register</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section d-flex align-items-center">
        <div class="container">
            <div class="row justify-content-center text-center">
                <div class="col-lg-8">
                    <p class="text-warning mb-3">Flash Sale Platform</p>
                    <h1 class="display-4 fw-bold mb-4">
                        Grab Exclusive Deals<br>Before They're Gone
                    </h1>
                    <p class="text-secondary mb-5 mx-auto" style="max-width: 500px;">
                        Get up to 90% off on premium products. Limited stock, limited time. Be fast, save big.
                    </p>
                    <div class="d-flex justify-content-center gap-3 mb-5">
                        <a href="/register" class="btn btn-warning px-4">Get Started</a>
                        <a href="#features" class="btn btn-outline-secondary px-4">Learn More</a>
                    </div>
                    
                    <!-- Simple Stats -->
                    <div class="d-flex justify-content-center gap-5 mt-5">
                        <div class="text-center">
                            <h4 class="fw-bold mb-0">50K+</h4>
                            <small class="text-secondary">Users</small>
                        </div>
                        <div class="text-center">
                            <h4 class="fw-bold mb-0">1M+</h4>
                            <small class="text-secondary">Deals</small>
                        </div>
                        <div class="text-center">
                            <h4 class="fw-bold mb-0">99%</h4>
                            <small class="text-secondary">Happy</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold mb-2">Why BoltClaim?</h2>
                <p class="text-secondary">Simple, fast, and secure</p>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-md-4">
                    <div class="feature-card rounded-3 p-4 h-100">
                        <i class="bi bi-lightning text-warning fs-3 mb-3"></i>
                        <h5 class="mb-2">Lightning Fast</h5>
                        <p class="text-secondary small mb-0">Claim deals instantly. No delays, no lag.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card rounded-3 p-4 h-100">
                        <i class="bi bi-shield-check text-success fs-3 mb-3"></i>
                        <h5 class="mb-2">Secure</h5>
                        <p class="text-secondary small mb-0">Your data is protected with enterprise-grade security.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card rounded-3 p-4 h-100">
                        <i class="bi bi-percent text-primary fs-3 mb-3"></i>
                        <h5 class="mb-2">Best Prices</h5>
                        <p class="text-secondary small mb-0">Up to 90% off on premium brands.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5 border-top border-dark">
        <div class="container text-center py-4">
            <h4 class="fw-bold mb-3">Ready to start saving?</h4>
            <a href="/register" class="btn btn-warning px-4">Create Free Account</a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="py-4 border-top border-dark">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <small class="text-secondary">© 2026 BoltClaim</small>
                <div class="d-flex gap-3">
                    <a href="#" class="text-secondary"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="text-secondary"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>