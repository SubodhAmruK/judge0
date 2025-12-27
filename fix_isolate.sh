#!/bin/bash
# Get fresh copy from image
docker run --rm binnubunny29/judge0:1.13.1-extra cat /api/app/jobs/isolate_job.rb > /tmp/isolate_job_clean.rb

# Apply fixes: remove cgroups flag, use -m for memory, add -p for processes
sed -i '57s/.*/    @cgroups = ""/' /tmp/isolate_job_clean.rb
sed -i 's/#{submission.enable_per_process_and_thread_memory_limit ? "-m " : "--cg-mem="}/-m /' /tmp/isolate_job_clean.rb
sed -i 's/-p#{Config::MAX_MAX_PROCESSES_AND_OR_THREADS}/-p120/' /tmp/isolate_job_clean.rb
sed -i 's/-p#{submission.max_processes_and_or_threads}/-p120/' /tmp/isolate_job_clean.rb
sed -i '/--cg-timing/d' /tmp/isolate_job_clean.rb
sed -i '/--no-cg-timing/d' /tmp/isolate_job_clean.rb

# Verify syntax
ruby -c /tmp/isolate_job_clean.rb

# Copy into running container
docker cp /tmp/isolate_job_clean.rb judge0-workers-1:/api/app/jobs/isolate_job.rb

echo "Fixed! Restarting workers..."
docker-compose restart workers
