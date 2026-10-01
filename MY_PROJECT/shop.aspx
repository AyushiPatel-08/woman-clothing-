<%@ Page Title="Shop" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="shop.aspx.cs" Inherits="MY_PROJECT.shop" %>

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
        .shop-hero {
            position: relative;
            overflow: hidden;
            padding: 36px 40px 56px;
            color: #fff;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .shop-hero::after {
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

        .shop-hero .hero-inner { position: relative; z-index: 2; max-width: 1100px; margin: 0 auto; }

        .shop-hero h4 {
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(34px, 5vw, 56px);
            line-height: 1.05;
            margin: 0 0 12px;
            color: #fff;
            text-transform: none;
        }

        .shop-hero p { margin: 0; font-size: 16px; color: rgba(255,255,255,0.85); }

        /* ---------- Product grid ---------- */
        .shop-wrapper { padding: 44px 24px 72px; background: var(--paper); }
        .shop-list { max-width: 1100px; margin: 0 auto; }

        /* DataList uses RepeatLayout="Flow", so the outer span becomes our grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 26px;
        }

        .product-card {
            padding: 12px 12px 18px;
            background: #fff;
            border: 1px solid var(--line);
            border-radius: 18px;
            transition: border-color .2s ease, transform .2s ease, box-shadow .2s ease;
        }

        .product-card:hover {
            border-color: var(--red);
            transform: translateY(-4px);
            box-shadow: 0 16px 30px rgba(42, 20, 23, 0.10);
        }

        .product-image {
            display: block;
            width: 100%;
            height: auto;
            aspect-ratio: 1 / 1;
            object-fit: cover;
            border-radius: 12px;
            background: #f1e7e6;
        }

        .product-info { padding: 16px 6px 0; }

        .product-name {
            display: block;
            font-family: var(--display);
            font-size: 21px;
            font-weight: 700;
            line-height: 1.2;
            color: var(--ink);
            margin-bottom: 6px;
        }

        .product-price {
            display: block;
            font-size: 18px;
            font-weight: 700;
            color: var(--red);
            margin-bottom: 14px;
        }

        .product-meta {
            display: flex;
            gap: 28px;
            padding-top: 14px;
            border-top: 1px solid var(--line);
            font-size: 14px;
        }

        .meta-title { display: block; font-size: 12px; font-weight: 700; color: var(--muted); margin-bottom: 2px; }
        .meta-value { font-weight: 500; color: var(--ink); }

        /* ---------- Actions: View Details / Add to Cart ---------- */
        .product-actions {
            display: flex;
            gap: 10px;
            margin-top: 16px;
        }

        .product-actions a {
            flex: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            height: 44px;
            padding: 0 14px;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.01em;
            white-space: nowrap;
            text-decoration: none;
            border-radius: 999px;
            cursor: pointer;
            transition: background .2s ease, color .2s ease, border-color .2s ease, transform .15s ease, box-shadow .2s ease;
        }

        .product-actions a:active { transform: translateY(1px); }

        .product-actions a:focus-visible {
            outline: 2px solid var(--ink);
            outline-offset: 2px;
        }

        .btn-view {
            color: var(--ink);
            background: #fff;
            border: 1.5px solid var(--line);
        }

        .btn-view:hover { border-color: var(--red); color: var(--red); background: #fdf3f2; }

        .btn-cart {
            color: #fff;
            background: var(--red);
            border: 1.5px solid var(--red);
            box-shadow: 0 8px 16px rgba(202,21,21,0.25);
        }

        .btn-cart:hover { background: var(--red-deep); border-color: var(--red-deep); box-shadow: 0 10px 20px rgba(143,12,12,0.3); }

        /* Cart ImageButton: constrain the raw image into a proper round button */
        .btn-cart-img {
            flex: 0 0 auto;
            width: 44px !important;
            height: 44px !important;
            padding: 10px;
            object-fit: contain;
            background: var(--red);
            border: 1.5px solid var(--red);
            border-radius: 50%;
            box-shadow: 0 8px 16px rgba(202,21,21,0.25);
            cursor: pointer;
            box-sizing: border-box;
            transition: background .2s ease, border-color .2s ease, box-shadow .2s ease, transform .15s ease;
        }

        .btn-cart-img:hover {
            background: var(--red-deep);
            border-color: var(--red-deep);
            box-shadow: 0 10px 20px rgba(143,12,12,0.3);
        }

        .btn-cart-img:active { transform: translateY(1px); }

        .btn-cart-img:focus-visible {
            outline: 2px solid var(--ink);
            outline-offset: 2px;
        }

        @media (max-width: 640px) {
            .shop-hero { padding: 24px 24px 40px; }
            .shop-hero::after { right: -80px; }
            .shop-wrapper { padding: 32px 16px 56px; }
            .product-grid { grid-template-columns: repeat(2, 1fr); gap: 14px; }
            .product-name { font-size: 18px; }
            .product-meta { gap: 16px; flex-wrap: wrap; }
            .product-actions { flex-direction: column; }
        }

        @media (prefers-reduced-motion: reduce) {
            .product-card, .product-actions a { transition: none !important; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="shop-hero">
        <div class="hero-inner">
            <h4>Shop</h4>
            <p>Browse everything in one place.</p>
        </div>
    </div>

    <div class="shop-wrapper">
        <div class="shop-list">

            <asp:DataList ID="DataList1" runat="server"
                RepeatLayout="Flow"
                RepeatDirection="Horizontal"
                CssClass="product-grid" OnItemCommand="DataList1_ItemCommand">

                <ItemTemplate>

                    <div class="product-card">

                        <asp:Image ID="Image1" runat="server"
                            CssClass="product-image"
                            AlternateText="Product image"
                            ImageUrl='<%# Eval("Prod_Image") %>' />

                        <div class="product-info">

                            <asp:Label ID="Label1" runat="server"
                                CssClass="product-name"
                                Text='<%# Eval("Prod_Name") %>'></asp:Label>

                            <asp:Label ID="Label2" runat="server"
                                CssClass="product-price"
                                Text='<%# Eval("Prod_price") %>'></asp:Label>

<%--                            <div class="product-meta">
                                <div>
                                    <span class="meta-title">Size</span>
                                    <asp:Label ID="Label3" runat="server"
                                        CssClass="meta-value"
                                        Text='<%# Eval("Prod_Size") %>'></asp:Label>
                                </div>
                                <div>
                                    <span class="meta-title">Color</span>
                                    <asp:Label ID="Label4" runat="server"
                                        CssClass="meta-value"
                                        Text='<%# Eval("Prod_Color") %>'></asp:Label>
                                </div>
                            </div>--%>

                            <div class="product-actions">
                                <asp:LinkButton
                                    ID="LinkButton1"
                                    runat="server"
                                    CssClass="btn-view"
                                    Text="View Details"
                                    CommandName="cmd_dtl"
                                    CommandArgument='<%# Eval("Prod_Id") %>'>
                                </asp:LinkButton>

                                <asp:ImageButton
                                    ID="ImageButton1"
                                    runat="server"
                                    CssClass="btn-cart-img"
                                    ImageUrl="~/new_img/Allegro red icon.jpg"
                                    AlternateText="Add to cart" CommandArgument='<%# Eval("Prod_Id") %>' />
                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:DataList>

        </div>
    </div>

</asp:Content>
