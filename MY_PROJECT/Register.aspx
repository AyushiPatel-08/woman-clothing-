<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MY_PROJECT.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda:ital,wght@0,500;0,700;1,500&family=Manrope:wght@400;500;700&display=swap" rel="stylesheet" />

    <style>
        .auth-container {
            --red: #ca1515;
            --red-deep: #8f0c0c;
            --ink: #2a1417;
            --muted: #7d6b6d;
            --paper: #fbf8f7;
            --line: #e4d9d9;
            --display: "Bodoni Moda", "Didot", Georgia, serif;
            --body: "Manrope", "Segoe UI", Arial, sans-serif;

            max-width: 900px;
            margin: 40px auto 60px;
            font-family: var(--body);
            color: var(--ink);
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

        /* ---------- Header: pinstripe band ---------- */
        .auth-header {
            position: relative;
            overflow: hidden;
            padding: 44px 40px;
            color: #fff;
            text-align: left;
            margin: 0;
            background:
                repeating-linear-gradient(90deg, rgba(255,255,255,0.09) 0 1px, transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .auth-header::after {
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

        .auth-header h2 {
            position: relative;
            z-index: 2;
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(28px, 4vw, 42px);
            line-height: 1.1;
            letter-spacing: 0;
            text-transform: none;
            color: #fff;
            margin: 0 0 10px;
        }

        .auth-header p {
            position: relative;
            z-index: 2;
            margin: 0;
            font-size: 15px;
            line-height: 1.6;
            color: rgba(255,255,255,0.85);
            max-width: 460px;
        }

        /* ---------- Form body ---------- */
        .auth-body { padding: 36px 40px 40px; }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: 32px;
        }

        .form-group { position: relative; margin-bottom: 26px; }
        .form-group.full { grid-column: 1 / -1; }

        /* messages (works with your existing alert classes) */
        .alert-custom {
            display: block;
            padding: 12px 14px;
            margin-bottom: 24px;
            font-size: 14px;
            line-height: 1.5;
            border-left: 3px solid var(--muted);
            background: #f1ecec;
            color: var(--ink);
        }
        .alert-danger-custom  { border-left-color: var(--red);  background: #fdeceb; color: var(--red-deep); }
        .alert-success-custom { border-left-color: #2f7d4f; background: #e9f5ee; color: #1f5a37; }

        /* ---------- Underline fields with floating label ---------- */
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
            box-shadow: none;
            box-sizing: border-box;
            transition: border-color .2s ease;
        }

        .form-control-custom:hover { border-bottom-color: #c9b4b4; }
        .form-control-custom:focus { border-bottom-color: var(--red); box-shadow: none; }

        textarea.form-control-custom { height: 84px; resize: vertical; padding-top: 26px; }

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

        /* ---------- Static-label fields (gender, city, image) ---------- */
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

        /* Gender radio buttons */
        .radio-group { border-collapse: collapse; margin-top: 8px; }
        .radio-group td { padding: 0 22px 0 0; }

        .radio-group input {
            appearance: none;
            -webkit-appearance: none;
            width: 18px;
            height: 18px;
            margin: 0 8px 0 0;
            vertical-align: -4px;
            border: 1.5px solid #c9b4b4;
            border-radius: 50%;
            cursor: pointer;
            transition: background .15s ease, border-color .15s ease;
        }

        .radio-group input:checked {
            background: var(--red);
            border-color: var(--red);
            box-shadow: inset 0 0 0 3px var(--paper);
        }

        .radio-group label { font-size: 15px; font-weight: 500; color: var(--ink); cursor: pointer; margin: 0; }

        /* ---------- Buttons and links ---------- */
        .btn-submit {
            width: 100%;
            height: 54px;
            margin-top: 6px;
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

        .btn-submit:hover { background: var(--red-deep); }
        .btn-submit:active { transform: translateY(1px); }

        .auth-footer-link { margin-top: 26px; font-size: 14px; color: var(--muted); text-align: left; }

        .auth-footer-link a {
            color: var(--red);
            font-weight: 700;
            text-decoration: none;
            padding-bottom: 2px;
            background: linear-gradient(currentColor, currentColor) 0 100% / 100% 1.5px no-repeat;
        }

        .auth-footer-link a:hover { background-size: 0 1.5px; }

        .btn-submit:focus-visible,
        .auth-footer-link a:focus-visible,
        .radio-group input:focus-visible,
        input[type=file].form-control-custom:focus-visible {
            outline: 2px solid var(--ink);
            outline-offset: 3px;
        }

        /* ---------- Registered users table ---------- */
        .grid-section { margin-top: 44px; padding-top: 32px; border-top: 1px solid var(--line); }

        .grid-header-title {
            font-family: var(--display);
            font-weight: 700;
            font-size: 24px;
            color: var(--ink);
            margin: 0 0 18px;
            text-transform: none;
        }

        .table-responsive {
            overflow-x: auto;
            border: 1px solid var(--line);
            border-radius: 12px;
            background: #fff;
        }

        .user-grid { width: 100%; min-width: 1100px; border-collapse: collapse; font-size: 14px; }

        .user-grid th {
            background: var(--ink);
            color: #fff;
            font-weight: 700;
            font-size: 13px;
            padding: 14px 14px;
            text-align: left;
            white-space: nowrap;
        }

        .user-grid td {
            padding: 12px 14px;
            text-align: left;
            color: var(--ink);
            border-bottom: 1px solid #efe6e6;
            vertical-align: middle;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        .user-grid tr:last-child td { border-bottom: 0; }
        .user-grid tr:hover td { background: #fdf3f2; }

        .user-avatar { width: 46px; height: 46px; border-radius: 50%; object-fit: cover; border: 2px solid #f1dedb; }

        .user-grid a { font-weight: 700; text-decoration: none; color: var(--red); }
        .user-grid a:hover { text-decoration: underline; }
        .user-grid a[id*="LinkButton2"] { color: var(--muted); }
        .user-grid a[id*="LinkButton2"]:hover { color: var(--red-deep); }

        .grid-empty { padding: 24px; color: var(--muted); font-size: 14px; }

        /* ---------- Responsive ---------- */
        @media (max-width: 720px) {
            .auth-container { margin: 20px 12px 40px; border-radius: 16px; }
            .auth-header { padding: 32px 24px; }
            .auth-header::after { right: -60px; }
            .auth-body { padding: 28px 24px 32px; }
            .form-grid { grid-template-columns: 1fr; }
        }

        @media (prefers-reduced-motion: reduce) {
            .auth-container { animation: none; }
            * { transition: none !important; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container">
        <div class="auth-container">

            <div class="auth-header">
                <h2>Create your account</h2>
                <p>Join Ashion to save your details and check out faster.</p>
            </div>

            <div class="auth-body">

                <asp:Label ID="lblMessage" runat="server" CssClass="alert-custom" Visible="false"></asp:Label>

                <div class="form-grid">

                    <div class="form-group">
                        <asp:TextBox ID="txtnm" runat="server" CssClass="form-control-custom" placeholder=" "></asp:TextBox>
                        <asp:Label runat="server" AssociatedControlID="txtnm" CssClass="field-label" Text="Full name *"></asp:Label>
                    </div>

                    <div class="form-group">
                        <asp:TextBox ID="txtuname" runat="server" CssClass="form-control-custom" placeholder=" "></asp:TextBox>
                        <asp:Label runat="server" AssociatedControlID="txtuname" CssClass="field-label" Text="Username *"></asp:Label>
                    </div>

                    <div class="form-group">
                        <asp:TextBox ID="txteml" runat="server" TextMode="Email" CssClass="form-control-custom" placeholder=" "></asp:TextBox>
                        <asp:Label runat="server" AssociatedControlID="txteml" CssClass="field-label" Text="Email address *"></asp:Label>
                    </div>

                    <div class="form-group">
                        <asp:TextBox ID="txtmbl" runat="server" CssClass="form-control-custom" placeholder=" "></asp:TextBox>
                        <asp:Label runat="server" AssociatedControlID="txtmbl" CssClass="field-label" Text="Mobile number"></asp:Label>
                    </div>

                    <div class="form-group">
                        <span class="static-label">Gender</span>
                        <asp:RadioButtonList ID="rdbgen" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
                            <asp:ListItem Text="Male" Value="Male" Selected="True" />
                            <asp:ListItem Text="Female" Value="Female" />
                        </asp:RadioButtonList>
                    </div>

                    <div class="form-group is-static">
                        <asp:Label runat="server" AssociatedControlID="ddpct" CssClass="static-label" Text="City"></asp:Label>
                        <asp:DropDownList ID="ddpct" runat="server" CssClass="form-control-custom">
                            <asp:ListItem Text="Select your city" Value="" />
                            <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                            <asp:ListItem Text="Surat" Value="Surat" />
                            <asp:ListItem Text="Vadodara" Value="Vadodara" />
                            <asp:ListItem Text="Rajkot" Value="Rajkot" />
                            <asp:ListItem Text="Gandhinagar" Value="Gandhinagar" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group full">
                        <asp:TextBox ID="txtadd" runat="server" TextMode="MultiLine" CssClass="form-control-custom" placeholder=" "></asp:TextBox>
                        <asp:Label runat="server" AssociatedControlID="txtadd" CssClass="field-label" Text="Address"></asp:Label>
                    </div>

                    <div class="form-group is-static">
                        <asp:Label runat="server" AssociatedControlID="FileUpload1" CssClass="static-label" Text="Profile image"></asp:Label>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control-custom" />
                    </div>

                    <div class="form-group">
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control-custom" placeholder=" " TextMode="Password"></asp:TextBox>
                        <asp:Label runat="server" AssociatedControlID="TextBox1" CssClass="field-label" Text="Password *"></asp:Label>
                    </div>

                </div>

                <asp:Button ID="Button1" runat="server" Text="Create account" CssClass="btn-submit" OnClick="Button1_Click" />

                <div class="auth-footer-link">
                    Already registered? <a href="Login.aspx">Sign in</a>
                </div>

                <div class="grid-section">
                    <h4 class="grid-header-title">Registered users</h4>

                    <div class="table-responsive">
                        <asp:GridView ID="GridView1" runat="server" CssClass="user-grid" AutoGenerateColumns="False" GridLines="None" OnRowCommand="GridView1_RowCommand" EmptyDataText="No users registered yet." EmptyDataRowStyle-CssClass="grid-empty">
                            <Columns>
                                <asp:TemplateField HeaderText="Id">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Full name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Username">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Gender">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="City">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Address">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mobile">
                                    <ItemTemplate>
                                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Image">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" CssClass="user-avatar" ImageUrl='<%# Eval("Image") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Password">
                                    <ItemTemplate>
                                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("PassWord") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="edit_btn" CommandArgument='<%# Eval("Id") %>'>Edit</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="det_btn" CommandArgument='<%# Eval("Id") %>'>Delete</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
