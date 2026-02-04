<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - BoltClaim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #121212;
        }
        .sidebar {
            background: #1a1a1a;
            min-height: 100vh;
            width: 220px;
            position: fixed;
            left: 0;
            top: 0;
            border-right: 1px solid #2a2a2a;
        }
        .main-content {
            margin-left: 220px;
            background: #121212;
            min-height: 100vh;
        }
        .stat-card {
            background: #1e1e1e;
            border: 1px solid #2a2a2a;
            border-radius: 12px;
        }
        .sale-card {
            background: #1e1e1e;
            border: 1px solid #2a2a2a;
            border-radius: 12px;
            transition: all 0.2s ease;
        }
        .sale-card:hover {
            border-color: #ffc107;
        }
        .nav-link-custom {
            color: #888;
            padding: 10px 16px;
            border-radius: 8px;
            margin: 2px 8px;
            font-size: 14px;
        }
        .nav-link-custom:hover, .nav-link-custom.active {
            background: #252525;
            color: #fff;
        }
        .product-img {
            height: 140px;
            background: #252525;
            border-radius: 8px;
        }
        .progress-thin {
            height: 4px;
            background: #333;
        }
    </style>
</head>
<body class="text-white">

    <!-- Sidebar -->
    <aside class="sidebar p-3">
        <div class="py-3 mb-4">
            <h5 class="fw-bold mb-0">⚡ BoltClaim</h5>
        </div>
        
        <nav class="nav flex-column">
            <a class="nav-link-custom active d-flex align-items-center" href="/dashboard">
                <i class="bi bi-grid me-2"></i> Dashboard
            </a>
            <a class="nav-link-custom d-flex align-items-center" href="#">
                <i class="bi bi-lightning me-2"></i> Flash Sales
            </a>
            <a class="nav-link-custom d-flex align-items-center" href="#">
                <i class="bi bi-bag me-2"></i> My Claims
            </a>
            <a class="nav-link-custom d-flex align-items-center" href="#">
                <i class="bi bi-heart me-2"></i> Wishlist
            </a>
            <a class="nav-link-custom d-flex align-items-center" href="#">
                <i class="bi bi-gear me-2"></i> Settings
            </a>
        </nav>
        
        <div class="position-absolute bottom-0 start-0 end-0 p-3">
            <a href="/" class="btn btn-outline-secondary btn-sm w-100">
                <i class="bi bi-box-arrow-left me-2"></i>Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Bar -->
        <div class="border-bottom border-dark p-3 px-4">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="mb-0">Welcome, <span class="text-warning">${username}</span></h5>
                    <small class="text-secondary">Here's what's happening today</small>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <button class="btn btn-dark btn-sm">
                        <i class="bi bi-bell"></i>
                    </button>
                    <div class="bg-warning rounded-circle d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <span class="fw-bold text-dark" style="font-size: 14px;">${username.substring(0,1).toUpperCase()}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="p-4">
            <!-- Stats Row -->
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <div class="stat-card p-3">
                        <div class="d-flex align-items-center">
                            <div class="me-3">
                                <div class="bg-success bg-opacity-10 rounded p-2">
                                    <i class="bi bi-wallet2 text-success"></i>
                                </div>
                            </div>
                            <div>
                                <small class="text-secondary">Total Savings</small>
                                <h5 class="mb-0 fw-bold">₹12,450</h5>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card p-3">
                        <div class="d-flex align-items-center">
                            <div class="me-3">
                                <div class="bg-primary bg-opacity-10 rounded p-2">
                                    <i class="bi bi-bag-check text-primary"></i>
                                </div>
                            </div>
                            <div>
                                <small class="text-secondary">Deals Claimed</small>
                                <h5 class="mb-0 fw-bold">24</h5>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card p-3">
                        <div class="d-flex align-items-center">
                            <div class="me-3">
                                <div class="bg-danger bg-opacity-10 rounded p-2">
                                    <i class="bi bi-heart text-danger"></i>
                                </div>
                            </div>
                            <div>
                                <small class="text-secondary">Wishlist Items</small>
                                <h5 class="mb-0 fw-bold">8</h5>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card p-3">
                        <div class="d-flex align-items-center">
                            <div class="me-3">
                                <div class="bg-warning bg-opacity-10 rounded p-2">
                                    <i class="bi bi-lightning text-warning"></i>
                                </div>
                            </div>
                            <div>
                                <small class="text-secondary">Active Sales</small>
                                <h5 class="mb-0 fw-bold">156</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Flash Sales Section -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h6 class="fw-bold mb-0">Flash Deals</h6>
                <a href="#" class="text-warning text-decoration-none small">View All →</a>
            </div>

            <div class="row g-3 mb-4">
                <!-- Product 1 -->
                <div class="col-lg-3 col-md-6">
                    <div class="sale-card p-3">
                        <div class="product-img d-flex align-items-center justify-content-center mb-3">
                            <i class="bi bi-phone text-secondary" style="font-size: 3rem;"></i>
                        </div>
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h6 class="mb-0" style="font-size: 14px;">iPhone 15 Pro Max</h6>
                                <small class="text-secondary">256GB</small>
                            </div>
                            <span class="badge bg-danger" style="font-size: 10px;">-70%</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <span class="text-warning fw-bold">₹89,999</span>
                            <span class="text-decoration-line-through text-secondary ms-2 small">₹1,59,900</span>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <small class="text-secondary" style="font-size: 11px;">85% claimed</small>
                                <small class="text-secondary" style="font-size: 11px;">01:23:45</small>
                            </div>
                            <div class="progress progress-thin mt-1">
                                <div class="progress-bar bg-danger" style="width: 85%"></div>
                            </div>
                        </div>
                        <button class="btn btn-warning btn-sm w-100">Claim Deal</button>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="col-lg-3 col-md-6">
                    <div class="sale-card p-3">
                        <div class="product-img d-flex align-items-center justify-content-center mb-3">
                            <i class="bi bi-laptop text-secondary" style="font-size: 3rem;"></i>
                        </div>
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h6 class="mb-0" style="font-size: 14px;">MacBook Air M3</h6>
                                <small class="text-secondary">8GB, 256GB</small>
                            </div>
                            <span class="badge bg-danger" style="font-size: 10px;">-65%</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <span class="text-warning fw-bold">₹74,999</span>
                            <span class="text-decoration-line-through text-secondary ms-2 small">₹1,14,900</span>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <small class="text-secondary" style="font-size: 11px;">62% claimed</small>
                                <small class="text-secondary" style="font-size: 11px;">02:15:30</small>
                            </div>
                            <div class="progress progress-thin mt-1">
                                <div class="progress-bar bg-warning" style="width: 62%"></div>
                            </div>
                        </div>
                        <button class="btn btn-warning btn-sm w-100">Claim Deal</button>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="col-lg-3 col-md-6">
                    <div class="sale-card p-3">
                        <div class="product-img d-flex align-items-center justify-content-center mb-3">
                            <i class="bi bi-headphones text-secondary" style="font-size: 3rem;"></i>
                        </div>
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h6 class="mb-0" style="font-size: 14px;">Sony WH-1000XM5</h6>
                                <small class="text-secondary">Wireless ANC</small>
                            </div>
                            <span class="badge bg-danger" style="font-size: 10px;">-80%</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <span class="text-warning fw-bold">₹7,999</span>
                            <span class="text-decoration-line-through text-secondary ms-2 small">₹34,990</span>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <small class="text-secondary" style="font-size: 11px;">92% claimed</small>
                                <small class="text-secondary" style="font-size: 11px;">00:45:12</small>
                            </div>
                            <div class="progress progress-thin mt-1">
                                <div class="progress-bar bg-danger" style="width: 92%"></div>
                            </div>
                        </div>
                        <button class="btn btn-warning btn-sm w-100">Claim Deal</button>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="col-lg-3 col-md-6">
                    <div class="sale-card p-3">
                        <div class="product-img d-flex align-items-center justify-content-center mb-3">
                            <i class="bi bi-smartwatch text-secondary" style="font-size: 3rem;"></i>
                        </div>
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h6 class="mb-0" style="font-size: 14px;">Apple Watch Ultra 2</h6>
                                <small class="text-secondary">GPS + Cellular</small>
                            </div>
                            <span class="badge bg-danger" style="font-size: 10px;">-55%</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <span class="text-warning fw-bold">₹44,999</span>
                            <span class="text-decoration-line-through text-secondary ms-2 small">₹89,900</span>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <small class="text-secondary" style="font-size: 11px;">45% claimed</small>
                                <small class="text-secondary" style="font-size: 11px;">03:30:00</small>
                            </div>
                            <div class="progress progress-thin mt-1">
                                <div class="progress-bar bg-success" style="width: 45%"></div>
                            </div>
                        </div>
                        <button class="btn btn-warning btn-sm w-100">Claim Deal</button>
                    </div>
                </div>
            </div>

            <!-- Upcoming Sales -->
            <h6 class="fw-bold mb-3">Upcoming Sales</h6>
            <div class="row g-3">
                <div class="col-md-4">
                    <div class="stat-card p-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-primary bg-opacity-25 text-primary">Fashion</span>
                            <small class="text-secondary">in 5h 30m</small>
                        </div>
                        <h6 class="mb-1">Designer Brands Sale</h6>
                        <small class="text-secondary">Up to 70% off</small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card p-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-success bg-opacity-25 text-success">Home</span>
                            <small class="text-secondary">Tomorrow</small>
                        </div>
                        <h6 class="mb-1">Home Appliances Fest</h6>
                        <small class="text-secondary">Kitchen essentials</small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card p-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-warning bg-opacity-25 text-warning">Gaming</span>
                            <small class="text-secondary">Feb 5</small>
                        </div>
                        <h6 class="mb-1">Gaming Gear Madness</h6>
                        <small class="text-secondary">Consoles & accessories</small>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
