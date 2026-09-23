<%@ Page Title="Add Product" Language="C#" AutoEventWireup="true"
    CodeBehind="addproduct.aspx.cs"
    Inherits="MY_PROJECT.addproduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Add Product - Admin</title>

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

        .admin-header .section {
            font-size: 14px;
            color: rgba(255,255,255,0.65);
        }

        /* ---------- Card ---------- */
        .product-design-wrapper {
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

        .product-head {
            position: relative;
            overflow: hidden;
            padding: 40px;
            color: #fff;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .product-head::after {
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

        .product-head h1 {
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

        .product-status-text {
            position: relative;
            z-index: 2;
            font-size: 15px;
            color: rgba(255,255,255,0.85);
            text-align: left;
            margin: 0;
        }

        /* ---------- Form ---------- */
        .product-body { padding: 36px 40px 40px; }

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

        /* dropdown and file upload use a static label on top */
        .static-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--muted);
            margin-bottom: 4px;
        }

        .is-static .form-control-custom { padding: 8px 2px 6px; height: 46px; }

        select.form-control-custom {
            appearance: none;
            -webkit-appearance: none;
            cursor: pointer;
            padding-right: 28px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' fill='none' stroke='%23ca1515' stroke-width='2'%3E%3Cpath d='M1 1l5 5 5-5'/%3E%3C/svg%3E") no-repeat right 4px center;
        }

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
        .product-button-container { margin-top: 6px; text-align: left; }

        .btn-design-add-product {
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

        .btn-design-add-product:hover { background: var(--red-deep); }
        .btn-design-add-product:active { transform: translateY(1px); }

        .btn-design-add-product:focus-visible,
        input[type=file].form-control-custom:focus-visible {
            outline: 2px solid var(--ink);
            outline-offset: 3px;
        }

        /* ---------- Responsive ---------- */
        @media (max-width: 720px) {
            .admin-header { padding: 16px 20px; }
            .product-design-wrapper { margin: 20px 12px 40px; border-radius: 16px; }
            .product-head { padding: 30px 24px; }
            .product-head::after { right: -60px; }
            .product-body { padding: 28px 24px 32px; }
            .form-grid { grid-template-columns: 1fr; }
        }

        @media (prefers-reduced-motion: reduce) {
            .product-design-wrapper { animation: none; }
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
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="admin-header">
            <span class="brand">Ashion</span>
            <span class="section">Admin panel</span>
        </div>

        <div class="product-design-wrapper">

            <div class="product-head">
                <h1>Add product</h1>

                <div class="product-status-text">
                      <a href="ADMIN/A_Dashboard.aspx" class="home-link">Home</a>
                </div>
            </div>

            <div class="product-body">

                <div class="form-grid">

                    <!-- COMPANY -->
                    <div class="form-group is-static">
                        <asp:Label
                            ID="lblCompany"
                            runat="server"
                            AssociatedControlID="ddlCompanyName"
                            CssClass="static-label"
                            Text="Product company name">
                        </asp:Label>

                        <asp:DropDownList
                            ID="ddlCompanyName"
                            runat="server"
                            CssClass="form-control-custom"
                            AutoPostBack="True">

                            <asp:ListItem
                                Text="---Select Company---"
                                Value="---Select Company---">
                            </asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <!-- PRODUCT NAME -->
                    <div class="form-group">
                        <asp:TextBox
                            ID="txtProductName"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblProductName"
                            runat="server"
                            AssociatedControlID="txtProductName"
                            CssClass="field-label"
                            Text="Product name">
                        </asp:Label>
                    </div>

                    <!-- CATEGORY -->
                    <div class="form-group">
                        <asp:TextBox
                            ID="txtProductCategory"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblProductCategory"
                            runat="server"
                            AssociatedControlID="txtProductCategory"
                            CssClass="field-label"
                            Text="Product category">
                        </asp:Label>
                    </div>

                    <!-- PRICE -->
                    <div class="form-group">
                        <asp:TextBox
                            ID="txtProductprice"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblProductprice"
                            runat="server"
                            AssociatedControlID="txtProductprice"
                            CssClass="field-label"
                            Text="Product price">
                        </asp:Label>
                    </div>

                    <!-- SIZE -->
                    <div class="form-group">
                        <asp:TextBox
                            ID="txtProductsize"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblProductsize"
                            runat="server"
                            AssociatedControlID="txtProductsize"
                            CssClass="field-label"
                            Text="Product size">
                        </asp:Label>
                    </div>

                    <!-- COLOR -->
                    <div class="form-group">
                        <asp:TextBox
                            ID="txtProductcolor"
                            runat="server"
                            CssClass="form-control-custom"
                            placeholder=" ">
                        </asp:TextBox>

                        <asp:Label
                            ID="lblProductColor"
                            runat="server"
                            AssociatedControlID="txtProductcolor"
                            CssClass="field-label"
                            Text="Product color">
                        </asp:Label>
                    </div>

                    <!-- IMAGE -->
                    <div class="form-group full is-static">
                        <asp:Label
                            ID="lblProductImage"
                            runat="server"
                            AssociatedControlID="fileProductImage"
                            CssClass="static-label"
                            Text="Product image">
                        </asp:Label>

                        <asp:FileUpload
                            ID="fileProductImage"
                            runat="server"
                            CssClass="form-control-custom" />
                    </div>

                </div>

                <!-- ADD PRODUCT BUTTON -->
                <div class="product-button-container">
                    <asp:Button
                        ID="btnAddProduct"
                        runat="server"
                        Text="Add product"
                        CssClass="btn-design-add-product"
                        OnClick="btnAddProduct_Click" />
                </div>

            </div>

        </div>

    </form>

</body>

</html>
