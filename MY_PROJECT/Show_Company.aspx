<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Show_Company.aspx.cs" Inherits="MY_PROJECT.Show_Company" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Show Company</title>

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
        .show-company-hero {
            position: relative;
            overflow: hidden;
            padding: 36px 40px 56px;
            color: #fff;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .show-company-hero::after {
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

        .show-company-title {
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(34px, 5vw, 56px);
            line-height: 1.05;
            letter-spacing: 0;
            text-align: left;
            color: #fff;
            margin: 0 0 12px;
        }

        .hero-inner p { margin: 0; font-size: 16px; color: rgba(255,255,255,0.85); }

        /* ---------- Company grid ---------- */
        .show-company-wrapper { padding: 44px 24px 72px; }

        .company-list { max-width: 1100px; margin: 0 auto; width: auto; }

        /* DataList uses RepeatLayout="Flow", so the outer span becomes our grid */
        .company-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(210px, 1fr));
            gap: 26px;
        }

        .company-card {
            position: relative;
            width: auto;
            padding: 12px 12px 8px;
            text-align: left;
            background: #fff;
            border: 1px solid var(--line);
            border-radius: 18px;
            box-shadow: none;
            transition: border-color .2s ease, transform .2s ease, box-shadow .2s ease;
        }

        .company-card:hover {
            transform: translateY(-4px);
            border-color: var(--red);
            box-shadow: 0 16px 30px rgba(42, 20, 23, 0.10);
        }

        .company-image {
            display: block;
            width: 100%;
            height: auto;
            aspect-ratio: 4 / 3;
            object-fit: cover;
            border-radius: 12px;
            background: #f1e7e6;
        }

        .company-name {
            display: block;
            margin: 0;
            padding: 16px 6px 12px;
            font-family: var(--display);
            font-size: 21px;
            font-weight: 700;
            line-height: 1.2;
            color: var(--ink);
            text-decoration: none;
            transition: color .2s ease;
        }

        /* whole card is clickable through the name link */
        .company-name::after { content: ""; position: absolute; inset: 0; border-radius: 18px; }

        .company-card:hover .company-name { color: var(--red); }

        .company-name:focus-visible { outline: none; }
        .company-name:focus-visible::after { outline: 2px solid var(--ink); outline-offset: 3px; }

        /* ---------- Responsive ---------- */
        @media (max-width: 640px) {
            .show-company-hero { padding: 24px 24px 40px; }
            .brand { margin-bottom: 32px; }
            .show-company-hero::after { right: -80px; }
            .show-company-wrapper { padding: 32px 16px 56px; }
            .company-grid { grid-template-columns: repeat(2, 1fr); gap: 14px; }
            .company-name { font-size: 18px; padding: 12px 4px 8px; }
        }

        @media (prefers-reduced-motion: reduce) {
            * { transition: none !important; }
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="show-company-hero">
        <div class="hero-inner">
            <span class="brand">Ashion</span>
            <h1 class="show-company-title">Shop by company</h1>
            <p>Pick a company to see its products.</p>
        </div>
    </div>

    <div class="show-company-wrapper">

        <div class="company-list">

            <asp:DataList ID="DataList1"
                runat="server"
                RepeatLayout="Flow"
                RepeatDirection="Horizontal"
                CssClass="company-grid"
                OnItemCommand="DataList1_ItemCommand">

                <ItemTemplate>

                    <div class="company-card">

                        <asp:Image ID="Image1"
                            runat="server"
                            CssClass="company-image"
                            AlternateText="Company cover photo"
                            ImageUrl='<%# Eval("Comp_cover_Img") %>' />

                        <asp:LinkButton ID="LinkButton1"
                            runat="server"
                            CssClass="company-name"
                            CommandName="comp_name"
                            CommandArgument='<%# Eval("Id") %>'
                            Text='<%# Eval("Comp_Name") %>'>
                        </asp:LinkButton>

                    </div>

                </ItemTemplate>

            </asp:DataList>

        </div>

    </div>

</form>

</body>
</html>
