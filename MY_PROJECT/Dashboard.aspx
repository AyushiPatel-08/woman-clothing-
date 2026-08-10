<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MY_PROJECT.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-container {
            max-width: 900px;
            margin: 40px auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            padding: 35px;
            border: 1px solid #e1e1e1;
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f2f2f2;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        .dashboard-header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #111;
            margin: 0;
        }
        .btn-logout {
            background: #ca1515;
            color: #fff;
            border: none;
            padding: 10px 26px;
            font-weight: 700;
            border-radius: 6px;
            cursor: pointer;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .btn-logout:hover {
            background: #a80f0f;
        }
        .card-custom {
            background: #ffffff;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid #eaeaea;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
        }
        .card-custom h4 {
            color: #ca1515;
            font-weight: 700;
            margin-bottom: 20px;
            font-size: 20px;
            border-bottom: 2px solid #ca1515;
            display: inline-block;
            padding-bottom: 5px;
        }
        .info-row {
            display: flex;
            margin-bottom: 14px;
            font-size: 15px;
        }
        .info-label {
            font-weight: 700;
            width: 180px;
            color: #444;
        }
        .info-value {
            color: #111;
            font-weight: 500;
        }
        .gridview-profile {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background-color: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid #e1e1e1;
        }
        .gridview-profile th {
            background-color: #111111;
            color: #ffffff;
            font-weight: 700;
            padding: 14px 18px;
            text-align: left;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .gridview-profile td {
            padding: 14px 18px;
            border-bottom: 1px solid #eeeeee;
            font-size: 15px;
            color: #333333;
        }
        .gridview-profile tr:hover {
            background-color: #f9f9f9;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <div>
                    <h2>Welcome, <asp:Label ID="lblWelcomeName" runat="server"></asp:Label>!</h2>
                    <p style="color: #666; margin-top: 5px;">Your Profile & Authentication Status (Session & Cookies)</p>
                </div>
                <asp:Button ID="btnLogout" runat="server" Text="LOGOUT" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>

            <!-- User Profile Information Card (Key-Value Format) -->
            <div class="card-custom">
                <h4>User Profile Information</h4>
                <div class="info-row">
                    <div class="info-label">Full Name:</div>
                    <div class="info-value"><asp:Label ID="lblFullName" runat="server"></asp:Label></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Username:</div>
                    <div class="info-value"><asp:Label ID="lblUsername" runat="server"></asp:Label></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Email Address:</div>
                    <div class="info-value"><asp:Label ID="lblEmail" runat="server"></asp:Label></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Gender:</div>
                    <div class="info-value"><asp:Label ID="lblGender" runat="server"></asp:Label></div>
                </div>
            </div>

            <!-- User Profile GridView Card -->
            <div class="card-custom">
                <h4>User Information GridView</h4>
                <asp:GridView ID="gvUserProfile" runat="server" AutoGenerateColumns="True" CssClass="gridview-profile">
                    <HeaderStyle BackColor="#111111" ForeColor="White" Font-Bold="True" />
                    <RowStyle BackColor="#FFFFFF" ForeColor="#333333" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
