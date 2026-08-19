import { useEffect, useState } from "react";
import { getProjects } from "../api/projects.js";
import ProjectItem from "@/features/projects/components/ProjectItem.jsx";
import User from "@/features/users/components/User.jsx";

const PAGE_SIZE = 4;

function ProjectsPage() {
  const [projects, setProjects] = useState([]);
  const [pageInfo, setPageInfo] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  async function loadProjects(after = null) {
    try {
      setLoading(true);
      setError(null);
      const result = await getProjects({
        first: PAGE_SIZE,
        after,
      });

      const projectConnection =
        result?.projects;

      if (!projectConnection) {
        throw new Error(
          "Projects response is missing."
        );
      }

      setProjects(
        (currentProjects) =>
          after
            ? [
                ...currentProjects,
                ...projectConnection.nodes,
              ]
            : projectConnection.nodes
      );

      setPageInfo(
        projectConnection.pageInfo
      );
    } catch (error) {
      setError(
        error.message
      );
    } finally {
      setLoading(false);
    }
  }
  useEffect(() => {
   loadProjects();
  }, []);

  if (loading && projects.length === 0) {
   return <p>Loading...</p>;
  }

  return (
   <div>
     <h1 className={"text-red-600 text-4xl pb-4"}>Projects</h1>
     {error && (
       <p>Error: {error}</p>
     )}
     {projects.map((project) => (
       <div
         key = {project.id}
         className={"pb-2 mb-2 border-2 border-gray-700 rounded-lg p-2"}
       >
         <ProjectItem project = {project}/>
         <User user={project.owner} />
       </div>
      ))}
      {pageInfo?.hasNextPage && (
        <button
          className={"bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-1 rounded"}
          onClick={() => loadProjects(pageInfo.endCursor)}
          disabled={loading}
        >
          Load more
        </button>
      )}
    </div>
  );
}
export default ProjectsPage;