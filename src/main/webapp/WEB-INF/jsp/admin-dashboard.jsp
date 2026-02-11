<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard - BoltClaim</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
            <style>
                body {
                    background: #121212;
                    color: #e0e0e0;
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
                    color: #ffc107;
                }

                .card-custom {
                    background: #1e1e1e;
                    border: 1px solid #2a2a2a;
                    border-radius: 8px;
                }

                .table-dark-custom {
                    background-color: #1e1e1e;
                    color: #e0e0e0;
                }

                .table-dark-custom th,
                .table-dark-custom td {
                    border-color: #2a2a2a;
                }

                .modal-content-dark {
                    background-color: #1e1e1e;
                    color: #fff;
                    border: 1px solid #333;
                }

                .form-control-dark {
                    background-color: #2a2a2a;
                    border: 1px solid #444;
                    color: #fff;
                }

                .form-control-dark:focus {
                    background-color: #2a2a2a;
                    color: #fff;
                    border-color: #ffc107;
                    box-shadow: none;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <aside class="sidebar p-3">
                <div class="py-3 mb-4">
                    <h5 class="fw-bold mb-0 text-white">⚡ Admin Panel</h5>
                    <div class="mt-2 p-2" style="background:#252525; border-radius:8px;">
                        <small class="text-warning fw-bold d-block">${adminName}</small>
                        <small class="text-secondary">${adminEmail}</small>
                    </div>
                </div>

                <nav class="nav flex-column">
                    <a class="nav-link-custom active" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="bi bi-grid me-2"></i> Dashboard
                    </a>
                    <a class="nav-link-custom" href="#registeredUsersSection" onclick="scrollToUsers()">
                        <i class="bi bi-people me-2"></i> Users <span class="badge bg-warning text-dark ms-1">${registrationCount}</span>
                    </a>
                    <a class="nav-link-custom" href="#">
                        <i class="bi bi-gear me-2"></i> Settings
                    </a>
                </nav>

                <div class="position-absolute bottom-0 start-0 end-0 p-3">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm w-100">
                        <i class="bi bi-box-arrow-left me-2"></i>Logout
                    </a>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content p-4">

                <!-- Welcome Banner -->
                <div class="card mb-4" style="background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%); border: 1px solid #ffc107; border-radius: 12px;">
                    <div class="card-body p-4">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h3 class="text-white fw-bold mb-1">Welcome back, ${adminFullName}! 👋</h3>
                                <p class="text-secondary mb-0">Here's what's happening on your admin dashboard today.</p>
                            </div>
                            <div class="col-md-4 text-end">
                                <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 0.85rem;">
                                    <i class="bi bi-megaphone me-1"></i> ${campaignCount} Campaign(s)
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Profile Section -->
                <div class="card mb-4" style="background: #1e1e1e; border: 1px solid #2a2a2a; border-radius: 12px;">
                    <div class="card-body p-4">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <div class="d-flex align-items-center justify-content-center" 
                                     style="width: 64px; height: 64px; background: linear-gradient(135deg, #ffc107, #ff6b35); border-radius: 50%; font-size: 1.6rem; font-weight: bold; color: #000;">
                                    ${adminFullName.substring(0,1)}
                                </div>
                            </div>
                            <div class="col">
                                <h5 class="text-white fw-bold mb-1">${adminFullName}</h5>
                                <div class="d-flex gap-3 flex-wrap">
                                    <span class="text-secondary"><i class="bi bi-person me-1"></i> @${adminName}</span>
                                    <span class="text-secondary"><i class="bi bi-envelope me-1"></i> ${adminEmail}</span>
                                    <span class="badge bg-danger" style="font-size: 0.75rem;"><i class="bi bi-shield-lock me-1"></i>${adminRole}</span>
                                    <span class="text-secondary"><i class="bi bi-hash me-1"></i> ID: ${adminId}</span>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button class="btn btn-outline-warning btn-sm" data-bs-toggle="collapse" data-bs-target="#profileDetails">
                                    <i class="bi bi-chevron-down"></i>
                                </button>
                            </div>
                        </div>
                        <div class="collapse mt-3" id="profileDetails">
                            <hr style="border-color: #333;">
                            <div class="row text-center">
                                <div class="col-md-4">
                                    <div class="p-3" style="background: #252525; border-radius: 8px;">
                                        <h4 class="text-warning mb-0">${campaignCount}</h4>
                                        <small class="text-secondary">My Campaigns</small>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3" style="background: #252525; border-radius: 8px;">
                                        <h4 class="text-success mb-0">Active</h4>
                                        <small class="text-secondary">Account Status</small>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3" style="background: #252525; border-radius: 8px;">
                                        <h4 class="text-info mb-0">${adminRole}</h4>
                                        <small class="text-secondary">Access Level</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Campaign Management Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold mb-0">My Campaigns</h4>
                        <small class="text-secondary">Manage your flash sale campaigns</small>
                    </div>
                    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#createCampaignModal">
                        <i class="bi bi-plus-lg me-1"></i> New Campaign
                    </button>
                </div>

                <!-- Campaigns Table -->
                <div class="card card-custom p-0 overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-dark-custom table-hover mb-0 align-middle">
                            <thead class="bg-dark text-secondary small text-uppercase">
                                <tr>
                                    <th class="ps-4">SR#</th>
                                    <th>Campaign Name</th>
                                    <th>Status</th>
                                    <th>Start Time</th>
                                    <th>Inventory</th>
                                    <th class="text-end pe-4">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${campaigns}" var="c" varStatus="loop">
                                    <tr>
                                        <td class="ps-4">${loop.index + 1}</td>
                                        <td>
                                            <span
                                                class="badge bg-light text-dark border border-secondary text-wrap text-start"
                                                style="font-size: 0.9rem;">
                                                ${c.name}
                                            </span>
                                        </td>
                                        <td>
                                            <span
                                                class="badge ${c.status == 'ACTIVE' ? 'bg-success' : (c.status == 'UPCOMING' ? 'bg-primary' : 'bg-secondary')}">
                                                ${c.status}
                                            </span>
                                        </td>
                                        <td class="small text-secondary">${c.startTime}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${c.totalQty > 0}">
                                                    <div class="d-flex align-items-center">
                                                        <div class="progress flex-grow-1 me-2"
                                                            style="height: 6px; background: #333; width: 60px;">
                                                            <div class="progress-bar bg-warning" role="progressbar"
                                                                style="width: ${(c.availableQty * 100) / c.totalQty}%">
                                                            </div>
                                                        </div>
                                                        <small
                                                            class="text-secondary">${c.availableQty}/${c.totalQty}</small>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <small class="text-muted">No Inventory</small>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-4">
                                            <button class="btn btn-sm btn-outline-light me-1"
                                                onclick="openEditModal('${c.campaignId}', '${c.name}', '${c.description}', '${c.startTime}', '${c.status}')">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <form action="${pageContext.request.contextPath}/admin/delete-campaign"
                                                method="post" class="d-inline"
                                                onsubmit="return confirm('Delete this campaign?');">
                                                <input type="hidden" name="campaignId" value="${c.campaignId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty campaigns}">
                                    <tr>
                                        <td colspan="6" class="text-center py-5 text-secondary">
                                            <i class="bi bi-inbox fs-1 d-block mb-3"></i>
                                            No campaigns found. Create one to get started!
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Registered Users Section -->
                <div id="registeredUsersSection" class="mt-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h4 class="fw-bold mb-0"><i class="bi bi-people-fill me-2"></i>Registered Users</h4>
                            <small class="text-secondary">Users registered for your campaigns</small>
                        </div>
                        <span class="badge bg-info px-3 py-2" style="font-size: 0.85rem;">
                            <i class="bi bi-person-check me-1"></i> ${registrationCount} Registration(s)
                        </span>
                    </div>

                    <div class="card card-custom p-0 overflow-hidden">
                        <div class="table-responsive">
                            <table class="table table-dark-custom table-hover mb-0 align-middle">
                                <thead class="bg-dark text-secondary small text-uppercase">
                                    <tr>
                                        <th class="ps-4">SR#</th>
                                        <th>User</th>
                                        <th>Email</th>
                                        <th>Campaign</th>
                                        <th>Registered At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${registrations}" var="r" varStatus="loop">
                                        <tr>
                                            <td class="ps-4">${loop.index + 1}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-2" 
                                                         style="width: 32px; height: 32px; font-size: 12px; color: white;">
                                                        <c:choose>
                                                            <c:when test="${not empty r.userName}">
                                                                ${r.userName.substring(0,1).toUpperCase()}
                                                            </c:when>
                                                            <c:otherwise>U</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <span class="text-white">${not empty r.userFullName ? r.userFullName : r.userName}</span>
                                                        <small class="d-block text-secondary">@${r.userName}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-secondary">${r.userEmail}</td>
                                            <td>
                                                <span class="badge bg-warning text-dark">${r.campaignName}</span>
                                            </td>
                                            <td class="small text-secondary">${r.registeredAt}</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty registrations}">
                                        <tr>
                                            <td colspan="5" class="text-center py-5 text-secondary">
                                                <i class="bi bi-person-x fs-1 d-block mb-3"></i>
                                                No users have registered for your campaigns yet.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Create Campaign Modal -->
            <div class="modal fade" id="createCampaignModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content modal-content-dark">
                        <div class="modal-header border-secondary">
                            <h5 class="modal-title">Create Flash Sale</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/create-campaign" method="post">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Campaign Name</label>
                                    <input type="text" name="name" class="form-control form-control-dark" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Description</label>
                                    <textarea name="description" class="form-control form-control-dark"
                                        rows="2"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Start Time</label>
                                    <input type="datetime-local" name="startTime" class="form-control form-control-dark"
                                        required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small text-secondary">Total Quantity</label>
                                        <input type="number" name="totalQty" class="form-control form-control-dark"
                                            min="1" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small text-secondary">Status</label>
                                        <select name="status" class="form-control form-control-dark">
                                            <option value="UPCOMING">Upcoming</option>
                                            <option value="ACTIVE">Active</option>
                                            <option value="EXPIRED">Expired</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer border-secondary">
                                <button type="button" class="btn btn-outline-secondary"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-warning">Create Campaign</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Edit Campaign Modal -->
            <div class="modal fade" id="editCampaignModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content modal-content-dark">
                        <div class="modal-header border-secondary">
                            <h5 class="modal-title">Edit Campaign</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/update-campaign" method="post">
                            <input type="hidden" name="campaignId" id="editCampaignId">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Campaign Name</label>
                                    <input type="text" name="name" id="editCampaignName"
                                        class="form-control form-control-dark" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Description</label>
                                    <textarea name="description" id="editDescription"
                                        class="form-control form-control-dark" rows="2"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Start Time</label>
                                    <input type="datetime-local" name="startTime" id="editStartTime"
                                        class="form-control form-control-dark" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Status</label>
                                    <select name="status" id="editStatus" class="form-control form-control-dark">
                                        <option value="UPCOMING">Upcoming</option>
                                        <option value="ACTIVE">Active</option>
                                        <option value="EXPIRED">Expired</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer border-secondary">
                                <button type="button" class="btn btn-outline-secondary"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-warning">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function scrollToUsers() {
                    document.getElementById('registeredUsersSection').scrollIntoView({ behavior: 'smooth' });
                }

                function openEditModal(id, name, desc, start, status) {
                    document.getElementById('editCampaignId').value = id;
                    document.getElementById('editCampaignName').value = name;
                    document.getElementById('editDescription').value = desc;

                    const formatTime = (timeStr) => {
                        if (!timeStr) return '';
                        // Simple replacement to try matching datetime-local format T
                        return timeStr.replace(' ', 'T').substring(0, 16);
                    };

                    document.getElementById('editStartTime').value = formatTime(start);
                    document.getElementById('editStatus').value = status;

                    var modal = new bootstrap.Modal(document.getElementById('editCampaignModal'));
                    modal.show();
                }
            </script>
        </body>

        </html>