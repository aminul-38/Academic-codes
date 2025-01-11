#include <bits/stdc++.h>
#define ll long long
#define pb push_back
using namespace std;

struct Process
{
    int id;             // Process ID
    int arrivalTime;    // Arrival Time
    int burstTime;      // Burst Time
    int completionTime; // Completion Time
    int turnAroundTime; // Turnaround Time
    int waitingTime;    // Waiting Time
};

int main()
{
    int n;
    cout << "Enter the number of processes: ";
    cin >> n;

    vector<Process> processes(n);

    // Input Process details
    cout << "Enter Process_ID, Arrival_Time, and Burst_Time for each process:\n";
    for (int i = 0; i < n; i++)
    {
        cin >> processes[i].id >> processes[i].arrivalTime >> processes[i].burstTime;
    }

    // Sort processes by Arrival Time
    sort(processes.begin(), processes.end(), [](Process &a, Process &b)
         { return a.arrivalTime < b.arrivalTime; });

    // Calculate Completion Time, Turnaround Time, and Waiting Time
    int currentTime = 0;
    for (int i = 0; i < n; i++)
    {
        if (currentTime < processes[i].arrivalTime)
        {
            currentTime = processes[i].arrivalTime; // Idle CPU
        }
        processes[i].completionTime = currentTime + processes[i].burstTime;
        processes[i].turnAroundTime = processes[i].completionTime - processes[i].arrivalTime;
        processes[i].waitingTime = processes[i].turnAroundTime - processes[i].burstTime;

        currentTime = processes[i].completionTime; // Update current time
    }

    // Display the results
    cout << "\n+------------+--------------+------------+-----------------+-----------------+---------------+\n";
    cout << "| Process_ID | Arrival_Time | Burst_Time | Completion_Time | Turnaround_Time | Waiting_Time  |\n";
    cout << "+------------+--------------+------------+-----------------+-----------------+---------------+\n";

    for (const auto &p : processes)
    {
        cout << "| " << setw(10) << p.id
             << " | " << setw(12) << p.arrivalTime
             << " | " << setw(10) << p.burstTime
             << " | " << setw(15) << p.completionTime
             << " | " << setw(15) << p.turnAroundTime
             << " | " << setw(13) << p.waitingTime << " |\n";
    }

    cout << "+------------+--------------+------------+-----------------+-----------------+---------------+\n";

    return 0;
}
