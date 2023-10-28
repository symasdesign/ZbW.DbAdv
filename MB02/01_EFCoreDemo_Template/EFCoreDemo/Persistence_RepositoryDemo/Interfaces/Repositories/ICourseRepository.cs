using EFCoreDemo.Models;
using System.Collections.Generic;

namespace Repository.Core.Repositories
{
    public interface ICourseRepository : IRepository<Course>
    {
        IEnumerable<Course> GetTopSellingCourses(int count);
        IEnumerable<Course> GetCoursesWithAuthors(int pageIndex, int pageSize);
    }
}