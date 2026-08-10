using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MY_PROJECT
{
    public class UserModel
    {
        public string FullName { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Gender { get; set; }
        public DateTime RegisteredAt { get; set; }
    }

    public static class UserStore
    {
        private static readonly object _lock = new object();

        private static List<UserModel> Users { get; set; }

        static UserStore()
        {
            Users = new List<UserModel>
            {
                // Pre-seeded demo account for easy testing
                new UserModel
                {
                    FullName = "Admin User",
                    Username = "admin",
                    Email = "admin@example.com",
                    Password = "123",
                    Gender = "Male",
                    RegisteredAt = DateTime.Now
                }
            };
        }

        public static List<UserModel> GetAllUsers()
        {
            lock (_lock)
            {
                if (HttpContext.Current != null && HttpContext.Current.Application["UserList"] != null)
                {
                    return (List<UserModel>)HttpContext.Current.Application["UserList"];
                }

                if (HttpContext.Current != null)
                {
                    HttpContext.Current.Application["UserList"] = Users;
                }
                return Users;
            }
        }

        public static bool RegisterUser(UserModel newUser, out string errorMessage)
        {
            lock (_lock)
            {
                var list = GetAllUsers();

                if (list.Any(u => u.Username.Equals(newUser.Username, StringComparison.OrdinalIgnoreCase)))
                {
                    errorMessage = "Username already exists! Please choose another.";
                    return false;
                }

                if (list.Any(u => u.Email.Equals(newUser.Email, StringComparison.OrdinalIgnoreCase)))
                {
                    errorMessage = "Email is already registered!";
                    return false;
                }

                list.Add(newUser);
                if (HttpContext.Current != null)
                {
                    HttpContext.Current.Application["UserList"] = list;
                }

                errorMessage = string.Empty;
                return true;
            }
        }

        public static UserModel ValidateUser(string usernameOrEmail, string password)
        {
            lock (_lock)
            {
                var list = GetAllUsers();
                return list.FirstOrDefault(u =>
                    (u.Username.Equals(usernameOrEmail, StringComparison.OrdinalIgnoreCase) ||
                     u.Email.Equals(usernameOrEmail, StringComparison.OrdinalIgnoreCase)) &&
                    u.Password == password);
            }
        }
    }
}
