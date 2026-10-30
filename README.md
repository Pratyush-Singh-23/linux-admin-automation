# Linux Administration Automation

## Project Overview

Linux Administration Automation is a DevOps project developed using
Bash scripting on Amazon Linux 2023.

The project automates common Linux system administration tasks,
including user and group management, filesystem operations,
system resource monitoring, and report generation.

The project also integrates Git and GitHub for version control
and Docker for containerization.

## Objectives

- Automate Linux user and group administration.
- Manage directories, permissions, and ownership.
- Monitor CPU, memory, and disk utilization.
- Generate automated system monitoring reports.
- Implement periodic system monitoring.
- Maintain scripts using Git and GitHub.
- Containerize the application using Docker.

## Technologies Used

- Operating System: Amazon Linux 2023
- Scripting Language: Bash
- Version Control: Git
- Code Repository: GitHub
- Containerization: Docker

## Project Structure

linux-admin-automation/
│
├── scripts/
│   ├── user_group.sh
│   ├── filesystem.sh
│   └── system_monitor.sh
│
├── reports/
│   ├── disk_report_*.txt
│   └── system_report_*.txt
│
├── logs/
│
├── Dockerfile
├── .gitignore
└── README.md

## Script Descriptions

### 1. user_group.sh
Automates Linux user and group administration.

Features:
- Add and delete users.
- List system users.
- Create and delete groups.
- List system groups.
- Add users to supplementary groups.
- Remove users from supplementary groups.

### 2. filesystem.sh
Automates filesystem administration.

Features:
- Create and delete directories.
- List directories.
- Change file and directory permissions.
- Change ownership.
- Check filesystem and directory disk usage.
- Generate disk usage reports.

### 3. system_monitor.sh
Monitors system resources and generates reports.

Features:
- Monitor CPU utilization.
- Monitor memory utilization.
- Monitor disk utilization.
- Display system information.
- Generate timestamped monitoring reports.
- Perform periodic monitoring.
- Provide an interactive menu.

## Installation and Setup

### 1. Clone the Repository

git clone https://github.com/Pratyush-Singh-23/linux-admin-automation.git

### 2. Navigate to the Project

cd linux-admin-automation

### 3. Set Script Permissions

chmod +x scripts/*.sh

## Running the Scripts

### User and Group Management

sudo bash scripts/user_group.sh

### Filesystem Management

sudo bash scripts/filesystem.sh

### System Monitoring

sudo bash scripts/system_monitor.sh

## Docker Setup

### 1. Build Docker Image

docker build -t linux-admin-automation:1.0 .

### 2. Run Docker Container

docker run -it --name linux-admin-container linux-admin-automation:1.0

### 3. View Docker Containers

docker ps -a

### 4. View Docker Images

docker images

## Troubleshooting

### 1. Docker Package Conflict

Issue:
The Docker image build failed because coreutils conflicted
with the preinstalled coreutils-single package.

Solution:
Removed coreutils from the Dockerfile package installation list.

### 2. GitHub Authentication Error (403)

Issue:
Git push failed with a permission denied error.

Solution:
Generated a GitHub Personal Access Token (PAT) with
the required repository permissions and used it for HTTPS authentication.

### 3. Shell Script Execution

Issue:
Scripts require executable permissions and appropriate privileges.

Solution:
Used chmod +x to grant executable permissions and
ran administrative scripts with root privileges.

## Learning Outcomes

- Hands-on experience with Amazon Linux 2023 administration.
- Bash scripting and Linux command-line automation.
- Linux user, group, and filesystem management.
- CPU, memory, and disk monitoring.
- Automated report generation.
- Git version control and GitHub integration.
- Docker image creation and container execution.
- Troubleshooting Linux and Docker configuration issues.

## Author

**Pratyush Singh**

GitHub: https://github.com/Pratyush-Singh-23
