using System.ComponentModel;

namespace PeopleSaver.Models
{
    public class PersonViewModel
    {
        public Guid Id { get; set; }
        
        [DisplayName("First Name")]
        public string FirstName { get; set; }

        [DisplayName("Last Name")]
        public string LastName { get; set; }

        [DisplayName("Age")]
        public int Age { get; set; }
    }
}