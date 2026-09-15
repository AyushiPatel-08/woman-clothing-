<%@ Page Title="Add Company" Language="C#" AutoEventWireup="true"
    CodeBehind="addcompany.aspx.cs"
    Inherits="MY_PROJECT.addcompany" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Add Company - Admin</title>

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
        .admin-header {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            gap: 16px;
            padding: 18px 40px;
            background: var(--ink);
            color: #fff;
        }

        .admin-header .brand {
            font-family: var(--display);
            font-weight: 700;
            font-size: 24px;
            letter-spacing: 0.02em;
        }

        .admin-header .section { font-size: 14px; color: rgba(255,255,255,0.65); }

        /* ---------- Card ---------- */
        .company-design-wrapper {
            max-width: 760px;
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

        .company-head {
            position: relative;
            overflow: hidden;
            padding: 40px;
            color: #fff;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .company-head::after {
            content: "";
            position: absolute;
            right: 40px;
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
        }

        .company-head h1 {
            position: relative;
            z-index: 2;
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(30px, 4vw, 40px);
            line-height: 1.1;
            margin: 0 0 10px;
            letter-spacing: 0;
            text-align: left;
            color: #fff;
        }

        .company-head p {
            position: relative;
            z-index: 2;
            margin: 0;
            font-size: 15px;
            color: rgba(255,255,255,0.85);
        }

        /* Existing image button, kept as is */
        .company-result-text { padding: 20px 40px 0; text-align: left; }

        /* ---------- Form ---------- */
        .company-body { padding: 28px 40px 40px; }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: 32px;
        }

        .form-group { position: relative; margin-bottom: 26px; }
        .form-group.full { grid-column: 1 / -1; }

        .form-control-custom {
            width: 100%;
            height: 54px;
            padding: 22px 2px 6px;
            font-family: var(--body);
            font-size: 16px;
            color: var(--ink);
            background: transparent;
            border: 0;
            border-bottom: 1.5px solid var(--line);
            border-radius: 0;
            outline: none;
            transition: border-color .2s ease;
        }

        .form-control-custom:hover { border-bottom-color: #c9b4b4; }
        .form-control-custom:focus { border-bottom-color: var(--red); }

        .field-label {
            position: absolute;
            left: 2px;
            top: 17px;
            font-size: 16px;
            color: var(--muted);
            pointer-events: none;
            transform-origin: left top;
            transition: transform .2s ease, color .2s ease, font-size .2s ease;
        }

        .form-control-custom:focus + .field-label,
        .form-control-custom:not(:placeholder-shown) + .field-label {
            transform: translateY(-14px);
            font-size: 12px;
            font-weight: 700;
            color: var(--red);
        }

        .static-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--muted);
            margin-bottom: 4px;
        }

        .is-static .form-control-custom { padding: 8px 2px 6px; height: 46px; }

        input[type=file].form-control-custom { padding: 10px 0 8px; font-size: 14px; color: var(--muted); }

        input[type=file].form-control-custom::file-selector-button {
            font-family: var(--body);
            font-weight: 700;
            font-size: 13px;
            color: var(--red);
            background: #fff;
            border: 1.5px solid var(--red);
            border-radius: 999px;
            padding: 7px 18px;
            margin-right: 14px;
            cursor: pointer;
            transition: background .2s ease, color .2s ease;
        }

        input[type=file].form-control-custom::file-selector-button:hover { background: var(--red); color: #fff; }

        /* ---------- Button ---------- */
        .company-button-container { margin-top: 6px; }

        .btn-design-add {
            width: 100%;
            height: 54px;
            font-family: var(--body);
            font-size: 16px;
            font-weight: 700;
            letter-spacing: 0.02em;
            text-transform: none;
            color: #fff;
            background: var(--red);
            border: 0;
            border-radius: 999px;
            cursor: pointer;
            box-shadow: 0 10px 22px rgba(202,21,21,0.28);
            transition: background .2s ease, transform .15s ease;
        }

        .btn-design-add:hover { background: var(--red-deep); }
        .btn-design-add:active { transform: translateY(1px); }

        .btn-design-add:focus-visible,
        input[type=file].form-control-custom:focus-visible {
            outline: 2px solid var(--ink);
            outline-offset: 3px;
        }

        /* ---------- Responsive ---------- */
        @media (max-width: 720px) {
            .admin-header { padding: 16px 20px; }
            .company-design-wrapper { margin: 20px 12px 40px; border-radius: 16px; }
            .company-head { padding: 30px 24px; }
            .company-head::after { right: -60px; }
            .company-result-text { padding: 16px 24px 0; }
            .company-body { padding: 24px 24px 32px; }
            .form-grid { grid-template-columns: 1fr; }
        }

        @media (prefers-reduced-motion: reduce) {
            .company-design-wrapper { animation: none; }
            * { transition: none !important; }
                    
}
        .home-link {
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
        }
.home-link:hover {
    color: #fff;
    text-decoration: underline;
}
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="admin-header">
            <span class="brand">Ashion</span>
            <span class="section">Admin panel</span>
        </div>
         <div class="product-status-text">
      
 </div>

        <div class="company-design-wrapper">

            <div class="company-head">
                <h1>Add company</h1>
                <p>Enter the company details to add it to your catalog.</p>
                  <div class="product-status-text">
        <a href="ADMIN/A_Dashboard.aspx" class="home-link">Home</a>
  </div>
            </div>
             
            <!-- Existing Image Button -->
            <div class="company-result-text">
                <asp:ImageButton
                    ID="ImageButton1"
                    runat="server"
                    Height="46px"
                    Width="175px"
                    ImageUrl="~/new_img/button.png"
                    OnClick="ImageButton1_Click" />
            </div>

            <div class="company-body">

                <div class="form-grid">

                    <div class="form-group">
                        <asp:TextBox
                            ID="txtCompanyName"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblCompanyName"
                            runat="server"
                            AssociatedControlID="txtCompanyName"
                            CssClass="field-label"
                            Text="Company name">
                        </asp:Label>
                    </div>

                    <div class="form-group">
                        <asp:TextBox
                            ID="txtCompanyOwnerName"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblOwnerName"
                            runat="server"
                            AssociatedControlID="txtCompanyOwnerName"
                            CssClass="field-label"
                            Text="Company owner name">
                        </asp:Label>
                    </div>

                    <div class="form-group">
                        <asp:TextBox
                            ID="txtCompanyEmail"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblEmail"
                            runat="server"
                            AssociatedControlID="txtCompanyEmail"
                            CssClass="field-label"
                            Text="Company email">
                        </asp:Label>
                    </div>

                    <div class="form-group">
                        <asp:TextBox
                            ID="txtCompanyAddress"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblAddress"
                            runat="server"
                            AssociatedControlID="txtCompanyAddress"
                            CssClass="field-label"
                            Text="Company address">
                        </asp:Label>
                    </div>

                    <div class="form-group full is-static">
                        <asp:Label
                            ID="lblCoverPhoto"
                            runat="server"
                            AssociatedControlID="fileCoverPhoto"
                            CssClass="static-label"
                            Text="Company cover photo">
                        </asp:Label>

                        <asp:FileUpload
                            ID="fileCoverPhoto"
                            runat="server"
                            CssClass="form-control-custom" />
                    </div>

                </div>

                <div class="company-button-container">
                    <asp:Button
                        ID="btnAddCompany"
                        runat="server"
                        Text="Add company"
                        CssClass="btn-design-add"
                        OnClick="btnAddCompany_Click" />
                </div>

            </div>

        </div>

    </form>

</body>
</html>
