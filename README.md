# TODO

TODO tracking using yaml files for storage, and git for sync.

All tasks for a project defined in a yaml file in the `projects/` directory.

All tasks are assigned a unique identifier consisting of `{project}.{task_name}`. A shorter id is also created and assigned to a task whenever a new task is added, but this must only be done in the ci process in the "primary" location. For my purposes, the primary location will be github.com.


Running `gotask ci` should load and process all projects/tasks, and verify everything is sound. This includes...
- verifying linked tasks actually exist (`blockers`)
- assigning ids for each new task
- rejigger tasks that are completed


## Projects

A project consists of one or more tasks. Each project is contained within a single yaml file in the `projects` directory. Note that a project object is basically a task, but two properties (`name` and `effort`) are implicitly derived instead explicitly set. The `name` is simply the filename without the extension, and the effort is the total of all tasks within the file.


_example project with some tasks (`projects/website.yaml`)_
```yaml
details: things that need to be done on the website
blockers: []
tasks:
- name: update header
  description: the current header is gross; let's improve it
  tasks:
  - name: find new header font
    effort: 2
  - name: use svg for logo
- name: add snazzy 404 page
  tasks:
  - create 404 page
  - name: update nginx to serve the 404 page
    tasks:
    - determine whether we can serve json version for accept:application/json requests
```

## Tasks

A **task** is something that needs to be done. Tasks can contain other tasks. A task contains the following properties:

- `name` - short name for the task.
- `details` - more information about the thing that needs to be done
- `effort` - the esitmated duration for the task (10m, 3h, 1d, etc)
- `blockers` - the name of tasks that are blocking
- `tasks` - a list of subtasks

For top level tasks (ie the contents of a project file), the name is inferred from the file (`projects/website.yaml` -> `website`), and the effort duration is calculated from all tasks


## Actions

### `check`

Verify all data is sound. this is used before pushing tasks the the primary.

### `ids` (primary only)

Assign ids to all tasks that have not yet been assigned an id. This should

### `add`

Create a new task. Whenever this is complete it should echo a few things:
```
[{project}/{parent}.{name}]
[{project}/{parent}.{name}]
```


#### Create with only name

```
task add do thing
```

app should...
- prompt for project
- prompt for effort

#### Create with name and project

```
task add --project website do other thing
```

app should...
- prompt for effort

#### Create with name, project, effort

```
task add --project website.header --effort 30m use cool colors
```

