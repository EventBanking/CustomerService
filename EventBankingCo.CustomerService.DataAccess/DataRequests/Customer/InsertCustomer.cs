using EventBankingCo.Core.DataAccess.DataRequests;
using EventBankingCo.Core.Domain.Enums;

namespace EventBankingCo.CustomerService.DataAccess.DataRequests.Customer
{
    public class InsertCustomer : SqlCommand
    {
        public InsertCustomer(string memberId, string firstName, string lastName, string email, string phoneNumber, VerificationStatus verificationStatus)
        {
            MemberId = memberId;
            FirstName = firstName;
            LastName = lastName;
            Email = email;
            PhoneNumber = phoneNumber;
            VerificationStatus = verificationStatus;
        }

        public string MemberId { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Email { get; set; }

        public string PhoneNumber { get; set; }

        VerificationStatus VerificationStatus { get; set; }

        public override object? GetParameters() => this;

        public override string GetSql() =>
        @"
            INSERT INTO Customers (MemberId, FirstName, LastName, Email, PhoneNumber, VerificationStatus)
                           VALUES (@MemberId, @FirstName, @LastName, @Email, @PhoneNumber, @VerificationStatus)
        ";
    }
}
