namespace EventBankingCo.CustomerService.DataAccess.DataTransferObjects
{
    public class Customer_DTO
    {
        public int Id { get; set; }

        public string MemberId { get; set; } = string.Empty;

        public string FirstName { get; set; } = string.Empty;

        public string LastName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string PhoneNumber { get; set; } = string.Empty;

        public int VerificationStatusId { get; set; }

        public DateTime CreatedAtUTC { get; set; }

        public DateTime UpdateAtUTC { get; set; }
    }
}
