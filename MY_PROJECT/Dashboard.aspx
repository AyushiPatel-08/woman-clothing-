<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MY_PROJECT.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda:ital,wght@0,500;0,700;1,500&family=Manrope:wght@400;500;700&display=swap" rel="stylesheet" />

    <style>
        .dashboard-container {
            --red: #ca1515;
            --red-deep: #8f0c0c;
            --ink: #2a1417;
            --muted: #7d6b6d;
            --paper: #fbf8f7;
            --line: #e9dfdf;
            --display: "Bodoni Moda", "Didot", Georgia, serif;
            --body: "Manrope", "Segoe UI", Arial, sans-serif;

            max-width: 900px;
            margin: 40px auto 60px;
            font-family: var(--body);
            color: var(--ink);
            background: var(--paper);
            border: 1px solid var(--line);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 24px 48px rgba(42, 20, 23, 0.10);
            animation: settle .7s cubic-bezier(.2,.7,.2,1) both;
        }

        @keyframes settle {
            from { opacity: 0; transform: translateY(14px); }
            to   { opacity: 1; transform: none; }
        }

        /* ---------- Header: pinstripe fabric band ---------- */
        .dashboard-header {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            padding: 44px 40px;
            color: #fff;
            background:
                repeating-linear-gradient(90deg,
                    rgba(255,255,255,0.09) 0 1px,
                    transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .dashboard-header > div { position: relative; z-index: 2; }

        .dashboard-header h2 {
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(28px, 4vw, 42px);
            line-height: 1.1;
            margin: 0;
            color: #fff;
        }

        /* stitched button motif, echoing the login page */
        .dashboard-header::after {
            content: "";
            position: absolute;
            right: 130px;
            top: -90px;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background:
                radial-gradient(circle at 42% 42%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 58% 42%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 42% 58%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 58% 58%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 35% 30%, #fff8f6 0%, #f1dedb 60%, #e3c9c5 100%);
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
            opacity: 0.16;
            z-index: 1;
        }

        .btn-logout {
            position: relative;
            z-index: 2;
            font-family: var(--body);
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 0.02em;
            color: #fff;
            background: transparent;
            border: 1.5px solid rgba(255,255,255,0.75);
            border-radius: 999px;
            padding: 11px 28px;
            cursor: pointer;
            transition: background .2s ease, color .2s ease, border-color .2s ease;
        }

        .btn-logout:hover {
            background: #fff;
            color: var(--red-deep);
            border-color: #fff;
        }

        .btn-logout:focus-visible {
            outline: 2px solid #fff;
            outline-offset: 3px;
        }

        /* ---------- Body ---------- */
        .dashboard-body { padding: 36px 40px 40px; }

        .card-custom { margin-bottom: 32px; }
        .card-custom:last-child { margin-bottom: 0; }

        .card-custom h4 {
            font-family: var(--display);
            font-weight: 700;
            font-size: 24px;
            color: var(--ink);
            margin: 0 0 6px;
            padding: 0;
            border: 0;
            display: block;
        }

        /* ---------- Info rows ---------- */
        .info-list { margin-top: 10px; }

        .info-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 16px;
            align-items: baseline;
            padding: 18px 0;
            margin: 0;
            border-bottom: 1px solid var(--line);
            font-size: 16px;
        }

        .info-row:last-child { border-bottom: 0; }

        .info-label {
            width: auto;
            font-weight: 500;
            font-size: 14px;
            color: var(--muted);
        }

        .info-value {
            font-weight: 700;
            color: var(--ink);
            word-break: break-word;
        }

        /* ---------- GridView (kept ready in case you enable it) ---------- */
        .gridview-profile {
            width: 100%;
            margin-top: 15px;
            border-collapse: collapse;
            background: #fff;
            border: 1px solid var(--line);
            border-radius: 12px;
            overflow: hidden;
        }

        .gridview-profile th {
            background: var(--ink);
            color: #fff;
            font-weight: 700;
            font-size: 14px;
            padding: 14px 18px;
            text-align: left;
        }

        .gridview-profile td {
            padding: 14px 18px;
            font-size: 15px;
            color: var(--ink);
            border-bottom: 1px solid var(--line);
        }

        .gridview-profile tr:hover td { background: #fdf3f2; }

        /* ---------- Responsive ---------- */
        @media (max-width: 640px) {
            .dashboard-container { margin: 20px 12px 40px; border-radius: 16px; }
            .dashboard-header { flex-direction: column; align-items: flex-start; padding: 32px 24px; }
            .dashboard-header::after { right: -60px; top: -80px; }
            .dashboard-body { padding: 28px 24px 32px; }
            .info-row { grid-template-columns: 1fr; gap: 4px; padding: 14px 0; }
        }

        @media (prefers-reduced-motion: reduce) {
            .dashboard-container { animation: none; }
            * { transition: none !important; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container">
        <div class="dashboard-container">

            <div class="dashboard-header">
                <div>
                    <h2>Welcome, <asp:Label ID="lblWelcomeName" runat="server"></asp:Label>!</h2>
                </div>
                <asp:Button ID="btnLogout" runat="server" Text="Log out" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>

            <div class="dashboard-body">

                <!-- User Profile Information Card (Key-Value Format) -->
                <div class="card-custom">
                    <h4>Your profile</h4>
                    <div class="info-list">
                        <div class="info-row">
                            <div class="info-label">Full name</div>
                            <div class="info-value"><asp:Label ID="lblFullName" runat="server"></asp:Label></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Username</div>
                            <div class="info-value"><asp:Label ID="lblUsername" runat="server"></asp:Label></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Email address</div>
                            <div class="info-value"><asp:Label ID="lblEmail" runat="server"></asp:Label></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Gender</div>
                            <div class="info-value"><asp:Label ID="lblGender" runat="server"></asp:Label></div>
                        </div>
                    </div>
                </div>

                <%-- <!-- User Profile GridView Card -->
                <div class="card-custom">
                    <h4>User Information GridView</h4>
                    <asp:GridView ID="gvUserProfile" runat="server" AutoGenerateColumns="True" CssClass="gridview-profile">
                        <HeaderStyle BackColor="#111111" ForeColor="White" Font-Bold="True" />
                        <RowStyle BackColor="#FFFFFF" ForeColor="#333333" />
                    </asp:GridView>
                </div>--%>

            </div>
        </div>
    </div>
</asp:Content>
