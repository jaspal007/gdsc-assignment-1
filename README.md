# GDSC ASSIGNMENT 1
> DATE: 18 Sept, 2023 (MONDAY)

[![Flutter Bird v3](https://imgs.search.brave.com/GbKJMh7MM56wYJUauTCMnXj5OdDc1Qod1lXuGqsCnnE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9zdG9y/YWdlLmdvb2dsZWFw/aXMuY29tL2Ntcy1z/dG9yYWdlLWJ1Y2tl/dC9pbWFnZXMvRmx1/dHRlcjMxM19Db25j/ZXB0X0RfdjMud2lk/dGgtNjM1LnBuZw)](https://docs.flutter.dev/)
## AIM: Multi Search Functionality
You are required to create a **single page application** that implements a multi search functionality.

**Objective:** To practise how to modulate data on the basis of multiple queries and setting the order of priority of the filters.

### Required features of the application
1. The Application should comprise of a search bar that displays the list of items according to the content in search bar.
    > The default setting is to display all the list items if the search bar is empty.
2. The Application should also have drop down menus to sort the list **accordingly** on the basis of multiple queries like:
    - relevance,
    - low to high and vice versa,
    - date, etc
3. The application should be responsive and have space optimisizing layout for potrait and landscape mode **separately**.

   
# First steps to contribute to an Open Source Project
  ## Following are the steps to follow to successfully create a PR to be merged into main branch:
  > **Following steps are performed and depicted on an older version of GitHub so there can be some elemental UI changes but the process remains the same.**
  1. Go to the source repository and fork it.
     > ![forking a repo](https://www.dataschool.io/content/images/2020/06/github-02a.png)
  2. Clone the repository.
     > Navigate to the forked repo in your github and clone it in your local machine, using the command `git clone URL_OF_YOUR_FORK`
     ![cloning a repo](https://www.dataschool.io/content/images/2020/06/github-03.png)
  3. Now in the sub directory of that project create folder of your name `YOUR_NAME`.
  4. In that folder run the following command:
     > `flutter create [project_name]`
  5. Check the remote version of your project with the command `git remote -v`
     > - it should be `origin` by default
     > - if you don't see `origin` add it by the command `git remote add origin URL_OF_YOUR_FORK`
  6. Add source repository as `upstream` remote using the command `git remote add upstream URL_OF_SOURCE_REPO`
     > this is just a safety feature to lessen the chances of conflicting commits
  7. In your local project create a new branch `YOUR_NAME` using the command `git checkout -b [BRANCH_NAME]`
     > **all your commits until final merge will be through this branch only** to avoid mishandling of main branch.


  ## Commiting your changes and creating a PULL REQUEST:
  > **This is the most important part of a contribution to make a difference!**

  1. Once you have made the changes in your local machine, it is time to push those changes into your repository.

  - stage all the changes from the last commit: `git add .`
  - check the status of your staging: `git status`
  - commit your changes: `git commit -m "commit message"`
  - push your changes to **your branch**: `git push origin YOUR_BRANCH_NAME`

    This is what your repository should look like:
    ![pull request](https://www.dataschool.io/content/images/2020/06/github-12-revised.png)

  2. Simply create your **PULL REQUEST** and add required comments.
     > ![creating pull request](https://www.dataschool.io/content/images/2020/06/github-13.png)
  3. **Update your README.md before creating a PR to showcase your work**


# Updating the README.md
  * provide the detailed idea of your contribution.
  * be thorough with your knowledge.
  * mention the dependencies used in the project.

    ### Format of README.md
  
    1. Heading of your project
    2. Dependencies used along with a one line use case
    3. Screenshots of the working application.


# Resources
A raw json file to be used as a dummy data.
  > [<img alt="Resource" width="60px" src="https://imgs.search.brave.com/m39IRHRzwjCXfmZJCYO_ZInvWYS_P_Rd7fBn9MfJl08/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/a2luZHBuZy5jb20v/cGljYy9tLzE4MS0x/ODE3MDEwX2dpdGh1/Yi1naXRodWItaWNv/bi1oZC1wbmctZG93/bmxvYWQucG5n" />](/sample.json)


# References
> image references: [How to contribute on github](https://www.dataschool.io/how-to-contribute-on-github/)
