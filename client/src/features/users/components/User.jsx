function User(props) {
  const { user } = props;

  return (
   <div className={"user-container px-5 text-green-600"}>
     <h2>{user.email}</h2>
     <p>Role: {user.role}</p>
   </div>
  );
}
export default User;