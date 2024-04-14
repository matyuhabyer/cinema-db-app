<%-- 
    Document   : UpdateMovieDetailsAction
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="cinemapackage.Movies" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Movie Details Action</title>
</head>
<body>
<center>
    <%
        String movieName = request.getParameter("movieName");
        String updateField = request.getParameter("updateField");
        String newValue = request.getParameter("newValue");

        if (movieName == null || movieName.isEmpty() || updateField == null || updateField.isEmpty() || newValue == null || newValue.isEmpty()) {
            out.println("<p>Please fill in all fields.</p>");
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                    "root", "DLSU1234!");

                String query;
                PreparedStatement preparedStatement;
                ResultSet resultSet;

                query = "SELECT * FROM movie WHERE title LIKE ?";
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, "%" + movieName + "%");
                resultSet = preparedStatement.executeQuery();
                
                if (resultSet.next()) {
                    String title = resultSet.getString("title"); // Retrieve the title from the ResultSet
                    Movies movies = new Movies();
                    boolean updated = false;
                    switch (updateField) {
                        case "director":
                            updated = movies.updateDirector(connection, title, newValue);
                            break;
                        case "genre":
                            updated = movies.updateGenre(connection, title, newValue);
                            break;
                        case "releaseDate":
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            java.util.Date newReleaseDateUtil = sdf.parse(newValue);
                            // Convert java.util.Date to java.sql.Date
                            java.sql.Date newReleaseDate = new java.sql.Date(newReleaseDateUtil.getTime());
                            updated = movies.updateReleaseDate(connection, title, newReleaseDate);
                            break;
                        case "duration":
                            int newDuration = Integer.parseInt(newValue);
                            updated = movies.updateDuration(connection, title, newDuration);
                            break;
                        case "mtrcbRating":
                            updated = movies.updateMTRCBRating(connection, title, newValue);
                            break;
                        default:
                            out.println("<p>Invalid update field.</p>");
                    }

                    if (updated) {
                        out.println("<p>Movie record updated successfully.</p>");

                        query = "SELECT * FROM movie WHERE title LIKE ?";
                        preparedStatement = connection.prepareStatement(query);
                        preparedStatement.setString(1, "%" + movieName + "%");
                        resultSet = preparedStatement.executeQuery();
                        
                        if (resultSet.next()) {
                            out.println("<h3>Movie Details:</h3>");
                            out.println("<p>Title: " + resultSet.getString("title") + "</p>");
                            out.println("<p>Director: " + resultSet.getString("director") + "</p>");
                            out.println("<p>Genre: " + resultSet.getString("genre") + "</p>");
                            out.println("<p>Release Date: " + resultSet.getString("release_date") + "</p>");
                            out.println("<p>Duration: " + resultSet.getInt("duration") + " minutes</p>");
                            out.println("<p>MTRCB Rating: " + resultSet.getString("mtrcb_rating") + "</p>");
                        }
                    } else {
                        out.println("<p>Failed to update movie record. Please try again.</p>");
                    }
                } else {
                    out.println("<p>No movie found with the given name.</p>");
                }

                connection.close();
            } catch (NumberFormatException e) {
                out.println("<p>Invalid movie name.</p>");
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } catch (java.text.ParseException e) {
                out.println("<p>Error parsing date: " + e.getMessage() + "</p>");
            }
        }
    %>
    <br><br>
    <form action="MaintenanceMenu.jsp"><input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
</center>
</body>
</html>
