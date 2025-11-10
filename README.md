# TODO

TODO tracking using yaml files for storage, and git for sync.

## Projects

A project consists of one or more tasks. Each project is contained within a single yaml file in the `projects` directory.

_`projects/website.yaml`_
```yaml
description: things that need to be done on the website
blockers: []
tasks:
- name: update header
  description: the current header is gross; let's improve it
  tasks:
  - name: find new header font
    effort: 2
  - name: use svg for logo
- name:
```



## Tasks

Tasks are one or more things that need to be done.



- tasks are stored in yaml files in the `tasks/` directory.
- each yaml file represents a **project**.
- each tasks is a simple object
    - `name` - short name for the task. the `name` for a top level task in a file defaults to the filename of the yaml file.
    - `description` - more information about the thing that needs to be done
    - `blockers` - the name of tasks that are blocking
    - `tasks` - a list of subtasks
- a task ca be referred to by its `{filename}` or `{filename}.{taskname}`
