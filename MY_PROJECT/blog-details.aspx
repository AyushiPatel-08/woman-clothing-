<%@ Page Title="Blog Details" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="blog-details.aspx.cs" Inherits="MY_PROJECT.blog_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="index.aspx"><i class="fa fa-home"></i> Home</a>
                        <a href="blog.aspx">Blog</a>
                        <span>Blog Details</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Blog Details Section Begin -->
    <section class="blog-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-8">
                    <div class="blog__details__content">
                        <div class="blog__details__item">
                            <img src="img/blog/details/blog-details.jpg" alt="">
                            <div class="blog__details__item__title">
                                <span class="tip">Fashion</span>
                                <h4>No-Heat Waves Hair Tutorial</h4>
                                <ul>
                                    <li>by <span>Admin</span></li>
                                    <li>Seb 17, 2019</li>
                                    <li>3 Comments</li>
                                </ul>
                            </div>
                        </div>
                        <div class="blog__details__desc">
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->
</asp:Content>
