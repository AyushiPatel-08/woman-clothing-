<%@ Page Title="Shop Cart" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="shop-cart.aspx.cs"
    Inherits="MY_PROJECT.shop_cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <center>

        <div>
            <h2>Add to Cart</h2>

            <p>
                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
            </p>
        </div>

        <asp:GridView ID="GridView1" runat="server"
            AutoGenerateColumns="False">
           

            <Columns>

                <asp:TemplateField HeaderText="Product Id">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server"
                            Text='<%# Eval("Prod_Id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Product Img">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server"
                            ImageUrl='<%# Eval("Prod_Image") %>'
                            Width="100px"
                            Height="100px" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server"
                            Text='<%# Eval("Prod_Name") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Product Price">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server"
                            Text='<%# Eval("Prod_Price") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Quantity">

                    <EditItemTemplate>

                        <asp:DropDownList ID="DropDownList1" runat="server"
                            SelectedValue='<%# Eval("Cart_Qua") %>'>

                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                            <asp:ListItem Value="4">4</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="6">6</asp:ListItem>

                        </asp:DropDownList>

                    </EditItemTemplate>

                    <ItemTemplate>

                        <asp:Label ID="Label4" runat="server"
                            Text='<%# Eval("Cart_Qua") %>'>
                        </asp:Label>

                    </ItemTemplate>

                </asp:TemplateField>

                <asp:CommandField
                    HeaderText="Change Quantity"
                    ShowEditButton="True" />

            </Columns>

        </asp:GridView>

    </center>

</asp:Content>