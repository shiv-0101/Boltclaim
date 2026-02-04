<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - BoltClaim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; }
        .form-control {
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            color: #fff;
        }
        .form-control:focus {
            background: #1a1a1a;
            border-color: #ffc107;
            color: #fff;
            box-shadow: none;
        }
        .form-control::placeholder { color: #666; }
        .input-group-text {
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            color: #888;
        }
    </style>
</head>
<body class="text-white min-vh-100 d-flex align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="text-center mb-4">
                    <a href="/" class="text-decoration-none text-white">
                        <h4 class="fw-bold">⚡ BoltClaim</h4>
                    </a>
                </div>
                
                <div class="p-4 rounded-3" style="background: #111; border: 1px solid #222;">
                    <h5 class="text-center mb-4">Create an account</h5>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger py-2 small"><%= request.getAttribute("error") %></div>
                    <% } %>
                    
                    <form action="/register" method="POST">
                        <div class="mb-3">
                            <label class="form-label small text-secondary">Username</label>
                            <input type="text" name="username" class="form-control" placeholder="johndoe" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small text-secondary">Full Name</label>
                            <input type="text" name="fullName" class="form-control" placeholder="John Doe" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small text-secondary">Email</label>
                            <input type="email" name="email" class="form-control" placeholder="you@example.com" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label small text-secondary">Password</label>
                            <div class="input-group">
                                <input type="password" name="password" id="password" class="form-control" placeholder="••••••••" required>
                                <span class="input-group-text" style="cursor: pointer;" onclick="togglePassword()">
                                    <i class="bi bi-eye" id="eyeIcon"></i>
                                </span>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning w-100 mb-3">Create Account</button>
                    </form>
                    
                    <p class="text-center text-secondary small mb-0">
                        Already have an account? <a href="/login" class="text-warning text-decoration-none">Login</a>
                    </p>
                </div>
                
                <p class="text-center mt-4">
                    <a href="/" class="text-secondary small text-decoration-none">← Back to home</a>
                </p>
            </div>
        </div>
    </div>
    
    <script>
        function togglePassword() {
            var pwd = document.getElementById("password");
            var icon = document.getElementById("eyeIcon");
            if (pwd.type === "password") {
                pwd.type = "text";
                icon.className = "bi bi-eye-slash";
            } else {
                pwd.type = "password";
                icon.className = "bi bi-eye";
            }
        }
    </script>
</body>
</html>
