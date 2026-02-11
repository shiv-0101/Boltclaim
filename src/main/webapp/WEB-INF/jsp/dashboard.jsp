<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
                    color: #fff;
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
                    position: relative;
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
                    text-decoration: none;
                    display: block;
                }

                .nav-link-custom:hover,
                .nav-link-custom.active {
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

                .modal-content-dark {
                    background-color: #1e1e1e;
                    color: #fff;
                    border: 1px solid #333;
                }

                .btn-close-white {
                    filter: invert(1) grayscale(100%) brightness(200%);
                }

                a.see-more {
                    color: #ffc107;
                    text-decoration: none;
                    font-size: 0.8rem;
                }

                a.see-more:hover {
                    text-decoration: underline;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <aside class="sidebar p-3">
                <div class="py-3 mb-4">
                    <h5 class="fw-bold mb-0">⚡ BoltClaim</h5>
                </div>

                <nav class="nav flex-column">
                    <a class="nav-link-custom active d-flex align-items-center"
                        href="${pageContext.request.contextPath}/dashboard">
                        <i class="bi bi-grid me-2"></i> Dashboard
                    </a>
                    <a class="nav-link-custom d-flex align-items-center" href="#">
                        <i class="bi bi-lightning me-2"></i> Flash Sales
                    </a>
                    <a class="nav-link-custom d-flex align-items-center" href="#">
                        <i class="bi bi-bag me-2"></i> My Claims
                    </a>
                </nav>

                <div class="position-absolute bottom-0 start-0 end-0 p-3">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-secondary btn-sm w-100">
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
                            <div class="bg-warning rounded-circle d-flex align-items-center justify-content-center"
                                style="width: 36px; height: 36px;">
                                <span class="fw-bold text-dark" style="font-size: 14px;">${username != null ?
                                    username.substring(0,1).toUpperCase() : 'U'}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="p-4">
                    <!-- Flash Sales Section -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0">Flash Deals</h6>
                        <div class="text-warning small"><i class="bi bi-fire me-1"></i>Live Now</div>
                    </div>

                    <div class="row g-3 mb-4">
                        <c:if test="${empty campaigns}">
                            <div class="col-12 text-center py-5">
                                <i class="bi bi-hourglass-split fs-1 text-secondary mb-3 d-block"></i>
                                <p class="text-secondary">No active flash sales at the moment.</p>
                                <p class="text-secondary small">Check back soon for exclusive deals!</p>
                            </div>
                        </c:if>

                        <c:forEach items="${campaigns}" var="c">
                            <div class="col-lg-3 col-md-6">
                                <div class="sale-card p-3 h-100 d-flex flex-column">
                                    <div class="product-img d-flex align-items-center justify-content-center mb-3">
                                        <i class="bi bi-box-seam text-secondary" style="font-size: 3rem;"></i>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h6 class="mb-0 text-white text-truncate w-75" title="${c.name}">${c.name}</h6>
                                        <span class="badge ${c.status == 'ACTIVE' ? 'bg-danger' : 'bg-secondary'}"
                                            style="font-size: 10px;">${c.status}</span>
                                    </div>

                                    <div class="flex-grow-1 mb-2">
                                        <p class="text-secondary small mb-1 text-truncate" style="max-width: 100%;">
                                            <c:if test="${not empty c.description}">
                                                ${c.description}
                                            </c:if>
                                            <c:if test="${empty c.description}">
                                                No description available.
                                            </c:if>
                                        </p>
                                        <a href="#" class="see-more" data-bs-toggle="modal"
                                            data-bs-target="#descModal${c.campaignId}">See more</a>
                                    </div>

                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-end mb-1">
                                            <div>
                                                <small class="text-secondary d-block" style="font-size: 10px;">Start
                                                    Time</small>
                                                <small class="text-white"
                                                    style="font-size: 11px;">${c.startTime}</small>
                                            </div>
                                            <div class="text-end">
                                                <small class="text-secondary d-block" style="font-size: 10px;">
                                                    <c:choose>
                                                        <c:when test="${c.totalQty > 0}">
                                                            ${c.totalQty - c.availableQty} claimed
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </div>
                                        </div>

                                        <div class="progress progress-thin mb-3">
                                            <div class="progress-bar ${c.status == 'ACTIVE' ? 'bg-danger' : 'bg-secondary'}"
                                                role="progressbar"
                                                style="width: ${c.totalQty > 0 ? (c.totalQty - c.availableQty) * 100 / c.totalQty : 0}%">
                                            </div>
                                        </div>

                                        <c:choose>
                                            <c:when
                                                test="${c.status == 'ACTIVE' && c.availableQty > 0 && c.totalQty > 0}">
                                                <c:choose>
                                                    <c:when test="${registeredCampaigns.contains(c.campaignId)}">
                                                        <button class="btn btn-success btn-sm w-100" disabled>
                                                            <i class="bi bi-check-circle me-1"></i>Registered
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/register-campaign" method="post" class="d-inline w-100">
                                                            <input type="hidden" name="campaignId" value="${c.campaignId}">
                                                            <button type="submit" class="btn btn-warning btn-sm w-100 fw-bold">
                                                                <i class="bi bi-box-arrow-in-right me-1"></i>Register
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when
                                                test="${c.status == 'ACTIVE' && (c.availableQty == 0 || c.totalQty == 0)}">
                                                <button class="btn btn-secondary btn-sm w-100" disabled>Sold
                                                    Out</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-outline-secondary btn-sm w-100" disabled>Coming
                                                    Soon</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Description Modal -->
                            <div class="modal fade" id="descModal${c.campaignId}" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content modal-content-dark">
                                        <div class="modal-header border-secondary">
                                            <h5 class="modal-title text-warning">${c.name}</h5>
                                            <button type="button" class="btn-close btn-close-white"
                                                data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p class="text-secondary mb-1 small">Description</p>
                                            <p class="text-white">${c.description}</p>

                                            <hr class="border-secondary my-3">

                                            <div class="row text-center">
                                                <div class="col-6 border-end border-secondary">
                                                    <small class="d-block text-secondary">Start Time</small>
                                                    <span class="text-white fw-bold">${c.startTime}</span>
                                                </div>
                                                <div class="col-6">
                                                    <small class="d-block text-secondary">Available</small>
                                                    <span class="text-warning fw-bold">
                                                        <c:choose>
                                                            <c:when test="${c.totalQty > 0}">
                                                                ${c.availableQty} / ${c.totalQty}
                                                            </c:when>
                                                            <c:otherwise>0</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer border-secondary">
                                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                                data-bs-dismiss="modal">Close</button>
                                            <c:if test="${c.status == 'ACTIVE' && c.availableQty > 0}">
                                                <c:choose>
                                                    <c:when test="${registeredCampaigns.contains(c.campaignId)}">
                                                        <button class="btn btn-success btn-sm" disabled>
                                                            <i class="bi bi-check-circle me-1"></i>Registered
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/register-campaign" method="post" class="d-inline">
                                                            <input type="hidden" name="campaignId" value="${c.campaignId}">
                                                            <button type="submit" class="btn btn-warning btn-sm">Register Now</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>