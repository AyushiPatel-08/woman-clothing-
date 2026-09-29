<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="MY_PROJECT.Login" %>

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

        /* ---------- Split layout ---------- */
        .login-wrapper {
            min-height: calc(100vh - 92px);
            display: grid;
            grid-template-columns: 1.05fr 1fr;
        }

        /* ---------- Left: pinstripe fabric panel ---------- */
        .brand-panel {
            position: relative;
            overflow: hidden;
            color: #fff;
            padding: 56px 56px 48px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background:
                repeating-linear-gradient(90deg,
                    rgba(255,255,255,0.09) 0 1px,
                    transparent 1px 22px),
                linear-gradient(160deg, var(--red) 0%, var(--red-deep) 100%);
        }

        .brand-copy {
            position: relative;
            z-index: 2;
            max-width: 420px;
        }

        .brand-copy h2 {
            font-family: var(--display);
            font-weight: 500;
            font-size: clamp(38px, 4.6vw, 62px);
            line-height: 1.04;
            margin: 0 0 18px;
            color: #fff;
        }

        .brand-copy p {
            margin: 0;
            font-size: 15px;
            line-height: 1.7;
            color: rgba(255,255,255,0.82);
            max-width: 340px;
        }

        /* The one memorable element: a stitched garment button */
        .button-motif {
            position: absolute;
            right: -70px;
            bottom: -70px;
            width: 340px;
            height: 340px;
            border-radius: 50%;
            background: radial-gradient(circle at 35% 30%, #fff8f6 0%, #f1dedb 60%, #e3c9c5 100%);
            box-shadow: 0 30px 60px rgba(0,0,0,0.28), inset 0 -8px 18px rgba(120,20,20,0.18);
            z-index: 1;
        }

        /* stitched ring */
        .button-motif::before {
            content: "";
            position: absolute;
            inset: 26px;
            border-radius: 50%;
            border: 2px dashed rgba(143,12,12,0.45);
        }

        /* four thread holes */
        .button-motif::after {
            content: "";
            position: absolute;
            inset: 0;
            background:
                radial-gradient(circle at 42% 42%, #b58f8b 0 9px, transparent 10px),
                radial-gradient(circle at 58% 42%, #b58f8b 0 9px, transparent 10px),
                radial-gradient(circle at 42% 58%, #b58f8b 0 9px, transparent 10px),
                radial-gradient(circle at 58% 58%, #b58f8b 0 9px, transparent 10px);
        }

        /* ---------- Right: form ---------- */
        .form-panel {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px 32px;
            background: var(--paper);
        }

        .login-card {
            width: 100%;
            max-width: 400px;
            animation: settle 0.7s cubic-bezier(.2,.7,.2,1) both;
        }

        @keyframes settle {
            from { opacity: 0; transform: translateY(14px); }
            to   { opacity: 1; transform: none; }
        }

        .login-card-header { margin-bottom: 36px; }

        .login-card-header h3 {
            font-family: var(--display);
            font-weight: 700;
            font-size: 40px;
            line-height: 1.1;
            margin: 0 0 10px;
            color: var(--ink);
        }

        .login-card-header p {
            margin: 0;
            color: var(--muted);
            font-size: 15px;
            line-height: 1.6;
        }

        /* Message label (errors / info) */
        .login-msg {
            display: block;
            margin-bottom: 22px;
            padding: 12px 14px;
            border-left: 3px solid var(--red);
            background: #fdeceb;
            color: var(--red-deep);
            font-size: 14px;
            line-height: 1.5;
        }

        /* ---------- Floating-label underline fields ---------- */
        .form-group-custom {
            position: relative;
            margin-bottom: 28px;
        }

        .form-control-custom {
            width: 100%;
            height: 54px;
            padding: 22px 2px 6px;
            font-size: 16px;
            color: var(--ink);
            background: transparent;
            border: 0;
            border-bottom: 1.5px solid var(--line);
            border-radius: 0;
            outline: none;
            box-sizing: border-box;
            transition: border-color .2s ease;
        }

        .form-control-custom:hover { border-bottom-color: #c9b4b4; }
        .form-control-custom:focus { border-bottom-color: var(--red); }

        /* label sits after the input so we can react to its state */
        .field-label {
            position: absolute;
            left: 2px;
            top: 17px;
            font-size: 16px;
            color: var(--muted);
            pointer-events: none;
            transition: transform .2s ease, color .2s ease, font-size .2s ease;
            transform-origin: left top;
        }

        .form-control-custom:focus + .field-label,
        .form-control-custom:not(:placeholder-shown) + .field-label {
            transform: translateY(-14px);
            font-size: 12px;
            font-weight: 700;
            color: var(--red);
        }

        /* ---------- Remember me ---------- */
        .login-options { margin: -6px 0 30px; }

        .remember-checkbox { font-size: 14px; color: var(--muted); }

        .remember-checkbox input {
            appearance: none;
            -webkit-appearance: none;
            width: 18px;
            height: 18px;
            margin: 0 10px 0 0;
            vertical-align: -4px;
            border: 1.5px solid #c9b4b4;
            border-radius: 50%;
            cursor: pointer;
            transition: background .15s ease, border-color .15s ease, box-shadow .15s ease;
        }

        .remember-checkbox input:checked {
            background: var(--red);
            border-color: var(--red);
            box-shadow: inset 0 0 0 3px var(--paper);
        }

        .remember-checkbox label { cursor: pointer; }

        /* ---------- Button ---------- */
        .btn-login-submit {
            width: 100%;
            height: 54px;
            font-size: 16px;
            font-weight: 700;
            letter-spacing: 0.02em;
            color: #fff;
            background: var(--red);
            border: 0;
            border-radius: 999px;
            cursor: pointer;
            box-shadow: 0 10px 22px rgba(202,21,21,0.28);
            transition: background .2s ease, transform .15s ease, box-shadow .2s ease;
        }

        .btn-login-submit:hover {
            background: var(--red-deep);
            box-shadow: 0 12px 26px rgba(143,12,12,0.34);
        }

        .btn-login-submit:active { transform: translateY(1px); }

        /* ---------- Footer ---------- */
        .login-card-footer {
            margin-top: 34px;
            font-size: 14px;
            color: var(--muted);
        }

        .login-card-footer a {
            color: var(--red);
            font-weight: 700;
            text-decoration: none;
            background: linear-gradient(currentColor, currentColor) 0 100% / 100% 1.5px no-repeat;
            padding-bottom: 2px;
        }

        .login-card-footer a:hover { background-size: 0 1.5px; }

        /* ---------- Keyboard focus ---------- */
        .btn-login-submit:focus-visible,
        .login-card-footer a:focus-visible,
        .remember-checkbox input:focus-visible {
            outline: 2px solid var(--ink);
            outline-offset: 3px;
        }

        /* ---------- Responsive ---------- */
        @media (max-width: 860px) {
            .login-wrapper { grid-template-columns: 1fr; min-height: 0; }

            .brand-panel {
                padding: 32px 28px 36px;
                gap: 28px;
            }

            .brand-copy h2 { font-size: 34px; }
            .brand-copy p { display: none; }

            .button-motif {
                width: 200px;
                height: 200px;
                right: -50px;
                bottom: -60px;
            }

            .form-panel { padding: 40px 24px 56px; }
        }

        @media (prefers-reduced-motion: reduce) {
            .login-card { animation: none; }
            .login-wrapper * { transition: none !important; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="login-wrapper">

        <!-- Left: brand panel -->
        <div class="brand-panel">

            <div class="brand-copy">
                <h2>Your wardrobe is waiting.</h2>
                <p>Sign in to see your saved pieces, track your orders and check out faster.</p>
            </div>

            <div class="button-motif" aria-hidden="true"></div>
        </div>

        <!-- Right: form -->
        <div class="form-panel">

            <div class="login-card">

                <div class="login-card-header">
                    <h3>Welcome back</h3>
                    <p>Sign in to your account and pick up where you left off.</p>
                </div>

                <asp:Label ID="lblMessage"
                    runat="server"
                    CssClass="login-msg"
                    Visible="false">
                </asp:Label>

                <div class="form-group-custom">

                    <asp:TextBox
                        ID="txtUsername"
                        runat="server"
                        CssClass="form-control-custom"
                        placeholder=" ">
                    </asp:TextBox>

                    <asp:Label
                        runat="server"
                        AssociatedControlID="txtUsername"
                        CssClass="field-label"
                        Text="Username or email address">
                    </asp:Label>

                </div>

                <div class="form-group-custom">

                    <asp:TextBox
                        ID="txtPassword"
                        runat="server"
                        TextMode="Password"
                        CssClass="form-control-custom"
                        placeholder=" ">
                    </asp:TextBox>

                    <asp:Label
                        runat="server"
                        AssociatedControlID="txtPassword"
                        CssClass="field-label"
                        Text="Password">
                    </asp:Label>

                </div>

                <div class="login-options">

                    <asp:CheckBox
                        ID="chkRemember"
                        runat="server"
                        CssClass="remember-checkbox"
                        Text="Keep me signed in" />

                </div>

                <asp:Button
                    ID="btnLogin"
                    runat="server"
                    Text="Sign in"
                    CssClass="btn-login-submit"
                    OnClick="btnLogin_Click" />

                <div class="login-card-footer">

                    New to Ashion?

                    <a href="Register.aspx">Create an account</a>

                </div>

            </div>

        </div>

    </div>

</asp:Content>
