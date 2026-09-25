<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Show_Product.aspx.cs" Inherits="MY_PROJECT.Show_Product" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Show Products</title>

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
            background: var(--paper);
        }

        /* ---------- Header band ---------- */
        .products-hero {
            position: relative;
            overflow: hidden;
            padding: 36px 40px 56px;
            color: #fff;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .products-hero::after {
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

        .hero-inner { position: relative; z-index: 2; max-width: 1100px; margin: 0 auto; }

        .brand {
            display: block;
            font-family: var(--display);
            font-weight: 700;
            font-size: 24px;
            letter-spacing: 0.02em;
            margin-bottom: 44px;
        }

        .hero-inner h3 {
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(34px, 5vw, 56px);
            line-height: 1.05;
            margin: 0 0 12px;
            color: #fff;
        }

        .hero-inner p { margin: 0; font-size: 16px; color: rgba(255,255,255,0.85); min-height: 1.6em; }

        /* ---------- Product grid ---------- */
        .products-wrapper { padding: 44px 24px 72px; }
        .products-list { max-width: 1100px; margin: 0 auto; }

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
            transition: border-color .2s ease;
        }

        .product-card:hover { border-color: #c9b4b4; }

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

        /* ---------- Responsive ---------- */
        @media (max-width: 640px) {
            .products-hero { padding: 24px 24px 40px; }
            .brand { margin-bottom: 32px; }
            .products-hero::after { right: -80px; }
            .products-wrapper { padding: 32px 16px 56px; }
            .product-grid { grid-template-columns: repeat(2, 1fr); gap: 14px; }
            .product-name { font-size: 18px; }
            .product-meta { gap: 16px; flex-wrap: wrap; }
        }

        @media (prefers-reduced-motion: reduce) {
            * { transition: none !important; }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="products-hero">
            <div class="hero-inner">
                <span class="brand">Ashion</span>
                <h3>Products</h3>
                <p><asp:Label ID="Label3" runat="server"></asp:Label></p>
            </div>
        </div>

        <div class="products-wrapper">
            <div class="products-list">

                <asp:DataList ID="DataList1" runat="server"
                    RepeatLayout="Flow"
                    RepeatDirection="Horizontal"
                    CssClass="product-grid">

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
                                    Text='<%# Eval("Prod_Price") %>'></asp:Label>

                                <div class="product-meta">
                                    <div>
                                        <span class="meta-title">Size</span>
                                        <asp:Label ID="Label4" runat="server"
                                            CssClass="meta-value"
                                            Text='<%# Eval("Prod_Size") %>'></asp:Label>
                                    </div>
                                    <div>
                                        <span class="meta-title">Color</span>
                                        <asp:Label ID="Label5" runat="server"
                                            CssClass="meta-value"
                                            Text='<%# Eval("Prod_Color") %>'></asp:Label>
                                    </div>
                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:DataList>

            </div>
        </div>

    </form>
</body>
</html>
