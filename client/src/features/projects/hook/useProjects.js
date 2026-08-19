import { useState, useCallback } from "react";
import { getProjects } from "../api/projects.js"; // Adjust path as needed

const PAGE_SIZE = 5;

function useProjects() {
  const [projects, setProjects] = useState([]);
  const [pageInfo, setPageInfo] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const loadProjects = useCallback(async (after = null) => {
    try {
      setLoading(true);
      setError(null);

      const result = await getProjects({
        first: PAGE_SIZE,
        after,
      });

      const projectConnection = result?.projects;

      if (!projectConnection) {
        throw new Error("Projects response is missing.");
      }

      const newNodes = projectConnection.nodes ?? [];

      setProjects((currentProjects) =>
        after ? [...currentProjects, ...newNodes] : newNodes
      );

      setPageInfo(projectConnection.pageInfo ?? null);
    } catch (err) {
      setError(err?.message || "An unexpected error occurred.");
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    projects,
    pageInfo,
    loading,
    error,
    loadProjects,
  };
}

export { useProjects };