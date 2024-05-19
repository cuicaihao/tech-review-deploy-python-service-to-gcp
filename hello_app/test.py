import platform
import pkg_resources

# Print the Python version
print("Python version: ", platform.python_version())

# Print the installed packages
print("\nInstalled packages:")
for package in pkg_resources.working_set:
    print(package)