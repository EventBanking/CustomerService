namespace EventBankingCo.CustomerService.DataAccess.DataTransferObjects
{
    public class CustomerAddress_DTO
    {
        public int Id { get; set; }

        public int CustomerId { get; set; }

        public string Street1 { get; set; } = string.Empty;

        public string Street2 { get; set; } = string.Empty;

        public string City { get; set; } = string.Empty;

        public string StateName { get; set; } = string.Empty;

        public string StateAbbreviation { get; set; } = string.Empty;

        public string PostalCode { get; set; } = string.Empty;

        public DateTime CreatedAtUTC { get; set; }

        public DateTime UpdatedAtUTC { get; set; }
    }
}
