
namespace PeopleSaver.Models
{
    public class HomeIndexViewModel
    {
        public IList<PersonViewModel> People { get; set; }

        public HomeIndexViewModel()
        {
            People = new List<PersonViewModel>();
        }
    }
}