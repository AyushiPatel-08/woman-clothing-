<%@ Page Title="Main Page" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="MY_PROJECT.main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container" style="padding: 50px 0; text-align: center;">
        <h2>Welcome to Main Page</h2>
        <p>Your ASP.NET Web Application is successfully running!</p>
        <a href="shop.aspx" class="primary-btn" style="margin-top: 20px;">Explore Shop</a>
    </div>
</asp:Content>
