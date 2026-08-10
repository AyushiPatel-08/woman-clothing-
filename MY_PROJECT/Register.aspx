<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MY_PROJECT.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .auth-container {
            max-width: 900px;
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
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            font-size: 14px;
            display: block;
        }
        .form-control-custom {
            width: 100%;
            height: 48px;
            border: 1px solid #e1e1e1;
            border-radius: 6px;
            padding: 10px 15px;
            font-size: 14px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        .form-control-custom:focus {
            border-color: #ca1515;
            outline: none;
            box-shadow: 0 0 8px rgba(202, 21, 21, 0.2);
        }
        textarea.form-control-custom {
            height: 80px;
            resize: vertical;
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
        .alert-success-custom {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .radio-group label {
            font-weight: 400;
            margin-right: 15px;
            cursor: pointer;
        }
        .gridview-profile {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
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
        .gridview-profile img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container">
        <div class="auth-container">
            <div class="auth-header">
                <h2>Registration Form</h2>
                <p>Employee Registration</p>
            </div>

            <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>

            <div class="form-group">
                <label>Name</label>
                <asp:TextBox ID="txtnm" runat="server" CssClass="form-control-custom" placeholder="Enter name"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Gender</label>
                <asp:RadioButtonList ID="rdbgen" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Female" Value="Female" />
                </asp:RadioButtonList>
            </div>

            <div class="form-group">
                <label>Email</label>
                <asp:TextBox ID="txteml" runat="server" TextMode="Email" CssClass="form-control-custom" placeholder="Enter email"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>City</label>
                <asp:DropDownList ID="ddpct" runat="server" CssClass="form-control-custom">
                    <asp:ListItem Text="-- Select City --" Value="" />
                    <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                    <asp:ListItem Text="Surat" Value="Surat" />
                    <asp:ListItem Text="Vadodara" Value="Vadodara" />
                    <asp:ListItem Text="Rajkot" Value="Rajkot" />
                    <asp:ListItem Text="Gandhinagar" Value="Gandhinagar" />
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Address</label>
                <asp:TextBox ID="txtadd" runat="server" TextMode="MultiLine" CssClass="form-control-custom" placeholder="Enter address"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Mobile</label>
                <asp:TextBox ID="txtmbl" runat="server" CssClass="form-control-custom" placeholder="Enter mobile number"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Image</label>
                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control-custom" />
            </div>

            <asp:Button ID="Button1" runat="server" Text="Save" CssClass="btn-submit" OnClick="Button1_Click" />

            <!-- Employee Data GridView -->
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="gridview-profile">
                <HeaderStyle BackColor="#111111" ForeColor="White" Font-Bold="True" />
                <RowStyle BackColor="#FFFFFF" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="City" HeaderText="City" />
                    <asp:BoundField DataField="Address" HeaderText="Address" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                    <asp:ImageField DataImageUrlField="Image" HeaderText="Image" ControlStyle-Width="60" ControlStyle-Height="60" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="edit" CommandArgument='<%# Eval("Id") %>' Text="Edit" ForeColor="#ca1515" Font-Bold="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
