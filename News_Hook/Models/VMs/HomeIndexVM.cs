using NewsHook_Web.Models.DataBase;

namespace NewsHook_Web.Models.VMs
{
    public class HomeIndexVM
    {
        public IEnumerable<Event> Events { get; set; }
        public IEnumerable<News> News { get; set; }
        public IEnumerable<MediaLink> MediaLinks { get; set; }
    }
}
 