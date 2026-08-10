<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MY_PROJECT.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .auth-container {
            max-width: 480px;
            margin: 50px auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
            border: 1px solid #e1e1e1;
        }
        .auth-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .auth-header h2 {
            font-weight: 700;
            color: #111111;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .auth-header p {
            color: #666666;
            font-size: 14px;
        }
        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            font-size: 14px;
        }
        .form-control-custom {
            width: 100%;
            height: 48px;
            border: 1px solid #e1e1e1;
            border-radius: 6px;
            padding: 10px 15px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .form-control-custom:focus {
            border-color: #ca1515;
            outline: none;
            box-shadow: 0 0 8px rgba(202, 21, 21, 0.2);
        }
        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 15px 0;
            font-size: 14px;
            color: #555;
        }
        .btn-submit {
            width: 100%;
            height: 50px;
            background: #ca1515;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background: #a80f0f;
        }
        .auth-footer {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: #666666;
        }
        .auth-footer a {
            color: #ca1515;
            font-weight: 600;
            text-decoration: none;
        }
        .auth-footer a:hover {
            text-decoration: underline;
        }
        .alert-custom {
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .alert-danger-custom {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .alert-info-custom {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container">
        <div class="auth-container">
            <div class="auth-header">
                <h2>User Login</h2>
                <p>Sign in to your account</p>
            </div>

            <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>

            <div class="form-group">
                <label for="<%= txtUsername.ClientID %>">Username or Email</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control-custom" placeholder="Enter username or email"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="<%= txtPassword.ClientID %>">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control-custom" placeholder="Enter password"></asp:TextBox>
            </div>



            <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn-submit" OnClick="btnLogin_Click" />

            <div class="auth-footer">
                Don't have an account? <a href="Register.aspx">Register Here</a>
            </div>
        </div>
    </div>
</asp:Content>
