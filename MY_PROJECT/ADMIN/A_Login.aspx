<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="A_Login.aspx.cs" Inherits="MY_PROJECT.ADMIN.A_Login" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Login - Ashion</title>

    <style>
        .login-wrapper {
            padding: 60px 0;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            padding: 45px 40px;
            width: 100%;
            max-width: 450px;
            border: 1px solid #eaeaea;
        }

        .login-card-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-card-header h3 {
            font-weight: 700;
            color: #111111;
            font-size: 24px;
            margin-bottom: 8px;
            text-transform: uppercase;
        }

        .login-card-header p {
            color: #777777;
            font-size: 14px;
        }

        .form-group-custom {
            margin-bottom: 20px;
        }

        .form-group-custom label {
            font-weight: 600;
            color: #333333;
            font-size: 14px;
            margin-bottom: 8px;
            display: block;
        }

        .form-control-custom {
            width: 100%;
            height: 50px;
            border: 1px solid #e1e1e1;
            border-radius: 8px;
            padding: 10px 15px;
            font-size: 14px;
            box-sizing: border-box;
            background: #fafafa;
        }

        .form-control-custom:focus {
            border-color: #ca1515;
            background: #ffffff;
            outline: none;
        }

        .login-options {
            margin-bottom: 25px;
        }

        .remember-checkbox {
            color: #555555;
        }

        .btn-login-submit {
            width: 100%;
            height: 52px;
            background: #ca1515;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-login-submit:hover {
            background: #a80f0f;
        }

        .login-card-footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eeeeee;
            font-size: 14px;
            color: #666666;
        }

        .login-card-footer a {
            color: #ca1515;
            font-weight: 700;
            text-decoration: none;
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="login-wrapper">

        <div class="login-card">

            <div class="login-card-header">
                <h3>Welcome Back</h3>
                <p>Sign in to access your account & profile</p>
            </div>

            <asp:Label ID="lblMessage"
                runat="server"
                Visible="false">
            </asp:Label>

            <div class="form-group-custom">

                <label>Username or Email Address</label>

                <asp:TextBox
                    ID="txtUsername"
                    runat="server"
                    CssClass="form-control-custom"
                    placeholder="Enter username or email">
                </asp:TextBox>

            </div>

            <div class="form-group-custom">

                <label>Password</label>

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    TextMode="Password"
                    CssClass="form-control-custom"
                    placeholder="Enter your password">
                </asp:TextBox>

            </div>

            <div class="login-options">

                <label class="remember-checkbox">

                    <asp:CheckBox
                        ID="chkRemember"
                        runat="server" />

                    Remember Me

                </label>

            </div>

            <asp:Button
                ID="btnLogin"
                runat="server"
                Text="Sign In"
                CssClass="btn-login-submit"
                OnClick="btnLogin_Click" />

            

        </div>

    </div>

</form>

</body>
</html>

