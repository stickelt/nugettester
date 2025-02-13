using System;
using System.Diagnostics;
using System.IO;
using System.Linq;

class Program
{
    static void Main()
    {
        string userProfile = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
        string packageBase = Path.Combine(userProfile, ".nuget", "packages", "specialtydataarchive_oci.Core");

        if (!Directory.Exists(packageBase))
        {
            Console.WriteLine("NuGet package directory not found: " + packageBase);
            return;
        }

        // Get the highest version folder
        var versionDirs = Directory.GetDirectories(packageBase)
                                   .Select(Path.GetFileName)
                                   .OrderByDescending(v => v)
                                   .ToList();

        if (!versionDirs.Any())
        {
            Console.WriteLine("No version folders found.");
            return;
        }

        string latestVersion = versionDirs.First();
        string latestVersionPath = Path.Combine(packageBase, latestVersion, "build", "Version.props");

        if (!File.Exists(latestVersionPath))
        {
            Console.WriteLine($"Version.props not found in {latestVersionPath}");
            return;
        }

        string solutionRoot = Directory.GetCurrentDirectory(); // Adjust if needed
        string destinationPath = Path.Combine(solutionRoot, "Version.props");

        File.Copy(latestVersionPath, destinationPath, true);

        Console.WriteLine($"Copied {latestVersionPath} to {destinationPath}");
    }
}
