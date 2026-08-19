import { useEffect, useState } from "react";
import { getProjects } from "../api/projects.js";

const PAGE_SIZE = 10;

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
     <h1>Projects</h1>
     {error && (
       <p>Error: {error}</p>
     )}
     {projects.map((project) => (
       <div key={project.id}>
         <h2>{project.name}</h2>
          <p>
            {project.description}
          </p>
        </div>
      ))}
      {pageInfo?.hasNextPage && (
        <button
          onClick={() =>
            loadProjects(pageInfo.endCursor)
          }
          disabled={loading}
        >
          Load more
        </button>
      )}
    </div>
  );
}
export default ProjectsPage;