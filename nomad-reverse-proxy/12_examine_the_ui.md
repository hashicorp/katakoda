If you haven't already, open the [Nomad UI↗️]. This will open in a new
tab. Consider dragging the tab into its own window and arranging your
screen so that you can see the scenario and the UI window at the same time.

View the **fs_example** job by clicking on it in the Name column.

![UI screenshot showing an excerpt of the "Jobs" page highlighting the "fs_example" job](./assets/jobs_area.png)

Click on **Allocations** in the top bar and then click on the allocation ID
which is the first element in the Allocation table. Your ID will be different
for each instance of the job.

![UI screenshot showing "Allocations" page for the fs_example job](./assets/allocations_page.png)

Navigate to the fs-example task in the Tasks table. Click it to open the
specific task.

![UI screenshot showing "Tasks" table for the running allocation](./assets/tasks_table.png)

Click on the Logs tab to view the logs for the allocation.

![image](./assets/log_view.png)

Click back to the "Overview" tab, then click the "Exec" button on the top right
to open an exec window to the fs-example task.

![UI screenshot image of the exec button](./assets/exec_button.png)

Change the default command ("/bin/bash") to `/bin/sh` and press <key>Enter</key>

Run the `ls` command.

![UI screenshot showing the exec interface "The connection has closed" as the last message.](./assets/exec_output.png)


[Nomad UI↗️]: https://[[HOST_SUBDOMAIN]]-4646-[[KATACODA_HOST]].environments.katacoda.com/
