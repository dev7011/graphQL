function ProjectItem(props){
  const {project} = props

  return(
    <div className={"project-item-container"}>
      <h2 className={"text-red-800"}>{`${project.id}.  ${project.name}`}</h2>
      <p>
        {project.description}
      </p>
    </div>
  )
}

export default ProjectItem