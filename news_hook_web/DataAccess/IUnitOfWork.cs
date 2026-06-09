using Microsoft.EntityFrameworkCore;
using NewsHook_Web.Models.DataBase;

namespace NewsHook_Web.DataAccess
{
    public interface IUnitOfWork
    {
        public IRepository<Event> EventRepo { get; }
        public IRepository<MediaLink> MediaLinkRepo { get; }
        public IRepository<News> NewsRepo { get; }
        public IRepository<User> UserRepo { get; }
        void Save();
    }
}
