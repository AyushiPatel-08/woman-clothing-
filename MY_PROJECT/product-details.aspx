<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="product-details.aspx.cs" Inherits="MY_PROJECT.product_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --red: #ca1515;
            --red-deep: #8f0c0c;
            --ink: #2a1417;
            --muted: #7d6b6d;
            --paper: #fbf8f7;
            --line: #e4d9d9;
            --display: "Bodoni Moda", "Didot", Georgia, serif;
        }

        /* ---------- Header band ---------- */
        .details-hero {
            position: relative;
            overflow: hidden;
            padding: 36px 40px 56px;
            color: #fff;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .details-hero::after {
            content: "";
            position: absolute;
            right: 8%;
            top: -80px;
            width: 260px;
            height: 260px;
            border-radius: 50%;
            background:
                radial-gradient(circle at 42% 42%, #b58f8b 0 7px, transparent 8px),
                radial-gradient(circle at 58% 42%, #b58f8b 0 7px, transparent 8px),
                radial-gradient(circle at 42% 58%, #b58f8b 0 7px, transparent 8px),
                radial-gradient(circle at 58% 58%, #b58f8b 0 7px, transparent 8px),
                radial-gradient(circle at 35% 30%, #fff8f6 0%, #f1dedb 60%, #e3c9c5 100%);
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
            opacity: 0.16;
        }

        .details-hero .hero-inner { position: relative; z-index: 2; max-width: 1100px; margin: 0 auto; text-align: left; }

        .details-hero h2 {
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(34px, 5vw, 56px);
            line-height: 1.05;
            margin: 0 0 12px;
            color: #fff;
            text-transform: none;
        }

        .details-hero p { margin: 0; font-size: 16px; color: rgba(255,255,255,0.85); }

        /* ---------- Body ---------- */
        .details-wrapper { padding: 44px 24px 72px; background: var(--paper); }
        .details-list { max-width: 900px; margin: 0 auto; text-align: left; }

        .product-detail-card {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 40px;
            background: #fff;
            border: 1px solid var(--line);
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 24px 48px rgba(42, 20, 23, 0.08);
        }

        .detail-image {
            display: block;
            width: 100% !important;
            height: auto !important;
            aspect-ratio: 1 / 1;
            object-fit: cover;
            border-radius: 14px;
            background: #f1e7e6;
        }

        .detail-info .product-name {
            display: block;
            font-family: var(--display);
            font-size: 30px;
            font-weight: 700;
            line-height: 1.15;
            color: var(--ink);
            margin-bottom: 10px;
        }

        .detail-info .product-price {
            display: block;
            font-size: 24px;
            font-weight: 700;
            color: var(--red);
            margin-bottom: 24px;
        }

        .detail-row {
            display: flex;
            gap: 16px;
            padding: 16px 0;
            border-bottom: 1px solid var(--line);
            font-size: 15px;
        }

        .detail-row:first-of-type { border-top: 1px solid var(--line); }

        .detail-label {
            width: 140px;
            flex-shrink: 0;
            font-weight: 700;
            font-size: 12px;
            letter-spacing: 0.03em;
            text-transform: uppercase;
            color: var(--muted);
            align-self: center;
        }

        .detail-value { font-weight: 500; color: var(--ink); align-self: center; }

        .detail-actions { display: flex; gap: 12px; margin-top: 28px; }

        .detail-actions a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            height: 48px;
            padding: 0 24px;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 0.01em;
            white-space: nowrap;
            text-decoration: none;
            border-radius: 999px;
            cursor: pointer;
            transition: background .2s ease, color .2s ease, border-color .2s ease, box-shadow .2s ease, transform .15s ease;
        }

        .detail-actions a:active { transform: translateY(1px); }

        .btn-back {
            color: var(--ink);
            background: #fff;
            border: 1.5px solid var(--line);
        }

        .btn-back:hover { border-color: var(--red); color: var(--red); background: #fdf3f2; }

        .btn-cart {
            color: #fff;
            background: var(--red);
            border: 1.5px solid var(--red);
            box-shadow: 0 8px 16px rgba(202,21,21,0.25);
        }

        .btn-cart:hover { background: var(--red-deep); border-color: var(--red-deep); box-shadow: 0 10px 20px rgba(143,12,12,0.3); }

        /* ---------- Responsive ---------- */
        @media (max-width: 720px) {
            .details-hero { padding: 24px 24px 40px; }
            .details-hero::after { right: -80px; }
            .details-wrapper { padding: 32px 16px 56px; }
            .product-detail-card { grid-template-columns: 1fr; padding: 22px; gap: 24px; }
            .detail-actions { flex-direction: column; }
            .detail-actions a { width: 100%; }
        }

        @media (prefers-reduced-motion: reduce) {
            .detail-actions a { transition: none !important; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="details-hero">
        <div class="hero-inner">
            <h2>Product details</h2>
            <p>Everything you need to know before you buy.</p>
        </div>
    </div>

    <div class="details-wrapper">
        <div class="details-list">

            <asp:DataList ID="DataList1" runat="server">

                <ItemTemplate>

                    <div class="product-detail-card">

                        <asp:Image
                            ID="Image1"
                            runat="server"
                            CssClass="detail-image"
                            AlternateText="Product image"
                            ImageUrl='<%# Eval("Prod_Image") %>' />

                        <div class="detail-info">

                            <asp:Label
                                ID="Label1"
                                runat="server"
                                CssClass="product-name"
                                Text='<%# Eval("Prod_Name") %>'>
                            </asp:Label>

                            <asp:Label
                                ID="Label3"
                                runat="server"
                                CssClass="product-price"
                                Text='<%# Eval("Prod_Price") %>'>
                            </asp:Label>

                            <div class="detail-row">
                                <span class="detail-label">Category</span>
                                <asp:Label
                                    ID="Label2"
                                    runat="server"
                                    CssClass="detail-value"
                                    Text='<%# Eval("Prod_Category") %>'>
                                </asp:Label>
                            </div>

                            <div class="detail-row">
                                <span class="detail-label">Size</span>
                                <asp:Label
                                    ID="Label5"
                                    runat="server"
                                    CssClass="detail-value"
                                    Text='<%# Eval("Prod_Size") %>'>
                                </asp:Label>
                            </div>

                            <div class="detail-row">
                                <span class="detail-label">Color</span>
                                <asp:Label
                                    ID="Label4"
                                    runat="server"
                                    CssClass="detail-value"
                                    Text='<%# Eval("Prod_Color") %>'>
                                </asp:Label>
                            </div>

                            <div class="detail-actions">
                                <a href="shop.aspx" class="btn-back">
                                    <i class="fa fa-arrow-left"></i> Back to shop
                                </a>
                               
                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:DataList>

        </div>
    </div>

</asp:Content>
