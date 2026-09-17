<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="A_Dashboard.aspx.cs" Inherits="MY_PROJECT.ADMIN.A_Dashboard" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Dashboard</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda:ital,wght@0,500;0,700;1,500&family=Manrope:wght@400;500;700&display=swap" rel="stylesheet" />

    <style>
        :root {
            --red: #ca1515;
            --red-deep: #8f0c0c;
            --ink: #2a1417;
            --muted: #7d6b6d;
            --paper: #fbf8f7;
            --line: #e4d9d9;
            --display: "Bodoni Moda", "Didot", Georgia, serif;
            --body: "Manrope", "Segoe UI", Arial, sans-serif;
        }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: var(--body);
            color: var(--ink);
            background: #f3eded;
        }

        /* ---------- Admin top bar ---------- */
        .topbar {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            padding: 18px 40px;
            background: var(--ink);
            color: #fff;
        }

        .topbar .brand {
            font-family: var(--display);
            font-weight: 700;
            font-size: 24px;
            letter-spacing: 0.02em;
        }

        .topbar .section { font-size: 14px; color: rgba(255,255,255,0.65); }

        /* ---------- Panel ---------- */
        .panel {
            max-width: 860px;
            margin: 40px auto 60px;
            background: var(--paper);
            border: 1px solid #e9dfdf;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 24px 48px rgba(42, 20, 23, 0.10);
            animation: settle .7s cubic-bezier(.2,.7,.2,1) both;
        }

        @keyframes settle {
            from { opacity: 0; transform: translateY(14px); }
            to   { opacity: 1; transform: none; }
        }

        .header {
            position: relative;
            overflow: hidden;
            padding: 48px 40px;
            text-align: left;
            color: #fff;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .header::after {
            content: "";
            position: absolute;
            right: 40px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background:
                radial-gradient(circle at 42% 42%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 58% 42%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 42% 58%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 58% 58%, #b58f8b 0 6px, transparent 7px),
                radial-gradient(circle at 35% 30%, #fff8f6 0%, #f1dedb 60%, #e3c9c5 100%);
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
            opacity: 0.16;
        }

        .header h1 {
            position: relative;
            z-index: 2;
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(32px, 5vw, 48px);
            line-height: 1.1;
            margin: 0 0 10px;
        }

        .header p {
            position: relative;
            z-index: 2;
            margin: 0;
            font-size: 15px;
            color: rgba(255,255,255,0.85);
        }

        /* ---------- Action rows ---------- */
        .container { padding: 8px 40px 16px; text-align: left; }

        .card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            padding: 28px 0;
            border-bottom: 1px solid var(--line);
        }

        .card:last-child { border-bottom: 0; }

        .card h2 {
            font-family: var(--display);
            font-weight: 700;
            font-size: 26px;
            margin: 0 0 6px;
        }

        .card p { margin: 0; font-size: 15px; color: var(--muted); }

        .btn {
            flex-shrink: 0;
            min-width: 168px;
            height: 48px;
            padding: 0 26px;
            font-family: var(--body);
            font-size: 15px;
            font-weight: 700;
            letter-spacing: 0.02em;
            color: #fff;
            background: var(--red);
            border: 0;
            border-radius: 999px;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(202,21,21,0.25);
            transition: background .2s ease, color .2s ease, transform .15s ease;
        }

        .btn:hover { background: var(--red-deep); }
        .btn:active { transform: translateY(1px); }

        /* Logout is the quiet action */
        .btn-quiet {
            color: var(--ink);
            background: transparent;
            border: 1.5px solid var(--line);
            box-shadow: none;
        }

        .btn-quiet:hover { background: var(--ink); color: #fff; border-color: var(--ink); }

        .btn:focus-visible { outline: 2px solid var(--ink); outline-offset: 3px; }

        /* ---------- Responsive ---------- */
        @media (max-width: 640px) {
            .topbar { padding: 16px 20px; }
            .panel { margin: 20px 12px 40px; border-radius: 16px; }
            .header { padding: 34px 24px; }
            .header::after { right: -70px; }
            .container { padding: 4px 24px 12px; }
            .card { flex-direction: column; align-items: stretch; gap: 16px; }
            .btn { width: 100%; }
        }

        @media (prefers-reduced-motion: reduce) {
            .panel { animation: none; }
            * { transition: none !important; }
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="topbar">
        <span class="brand">Ashion</span>
        <span class="section">Admin panel</span>
    </div>

    <div class="panel">

        <div class="header">
            <h1>Admin dashboard</h1>
            <p>Welcome, Admin. Choose what you want to manage.</p>
        </div>

        <div class="container">

            <div class="card">
                <div>
                    <h2>Company</h2>
                    <p>Add a new company to your catalog.</p>
                </div>

                <asp:Button ID="btnAddCompany"
                    runat="server"
                    Text="Add company"
                    CssClass="btn"
                    OnClick="btnAddCompany_Click" />
            </div>

            <div class="card">
                <div>
                    <h2>Products</h2>
                    <p>Add a new product with its price, size and image.</p>
                </div>

                <asp:Button ID="btnAddProduct"
                    runat="server"
                    Text="Add product"
                    CssClass="btn"
                    OnClick="btnAddProduct_Click" />
            </div>

            <div class="card">
                <div>
                    <h2>Log out</h2>
                    <p>End your admin session on this device.</p>
                </div>

                <asp:Button ID="btnLogout"
                    runat="server"
                    Text="Log out"
                    CssClass="btn btn-quiet"
                    OnClick="btnLogout_Click" />
            </div>

        </div>

    </div>

</form>

</body>
</html>
