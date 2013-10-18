# Analyses raw data from database.
# Input parameter is an array of IBIs (in milliseconds).
# Calculates all necessary information.
# Use "get" methods listed at the bottom.
module Analysis
	class << self
	# Global variables
	@@min_hr		# Minimum heart rate
	@@max_hr		# Maximum heart rate
	@@power	= []	# Array of percentage of power in LF band
	@@time	= []	# Array of time of every window
	@@mcf			# Most common frequency in LF band
	@@ttr			# Total time in resonance

	# Initialise.
	def initialize(ibi)
		# Analyse IBIs using Lomb method.
		analyse(ibi)
		# # Adjust amplitudes from Lomb method to PSDs.
		# for i in (0...@@power.length)
		# 	# Scalar is ONLY suitable for window_size = 128
		# 	@@power[i] /= 0.078345
		# end
	end

	# Calculate all necessary information.
	# Finds min/ max HR.
	# Generates x/ y series for (resonant) PSD vs time.
	# Finds most common frequency.
	# Finds total time spent in resonance.
	def analyse(ibi)
		# User defined variables.
		window_size = 128		# Size of each window being analysed
		window_shift = 50		# Distance between each window
		sample_rate = 10.0		# Sampling rate in Hz.
		# Find min/ max HR.
		@@min_hr = 60000.0/ibi.max
		@@max_hr = 60000.0/ibi.min
		# Prepare data for Lomb analysis.
		time, ibi = prepare(ibi)
		# Hash table to store cumulative power of every LF.
		total_frequency = Hash.new(0)
		# Loop through every full window in data set.
		# Increment current window by window shift.
		for i in (0..ibi.length-window_size).step(window_shift)
			# Do Lomb analysis.
			lomb = Lomb.fasper(time[i...i+window_size], ibi[i...i+window_size])
			# Update power, frequency, and time arrays.
			# Get peak frequency and power in LF band.
			frequency, power = Lomb.get_lf_peak
			# Get percentage of power in LF band.
			percentage = Lomb.get_lf_perc
			# Update total_frequency.
			total_frequency[frequency] += power
			# Update power.
			@@power << percentage
			# Time of window is defined as the time of the last beat in that window.
			# Time is shifted back so that the first time is at 0.
			@@time << time[i+window_size-1]-time[window_size-1]
		end
		# Because the time intervals are not uniformly distributed,
		# it may be difficult to generate a visual graph. 
		# Interpolate the time and ibi arrays to generate uniformly distributed (time) arrays.
		@@time, @@power = nni(@@time.clone, @@power.clone, sample_rate/1.0)
		# Most common frequency.
		@@mcf = (total_frequency.select { |k, v| v == total_frequency.values.max }.keys)[0].to_f
		# Total time in resonance.
		counter = 0
		# Find number of windows with resonance.
		for i in (0...@@time.length)
			if @@power[i] > 0
				counter += 1
			end
		end
		# Each window with resonance = sample_rate/1.0 seconds of resonance.
		@@ttr = counter*(sample_rate/1.0)
	end

	# Prepares the raw data for Lomb analysis.
	# Input parameter is an array of IBIs in milliseconds.
	# Returns time(x) and ibi(y) in seconds.
	def prepare(ibi)
		time = []
		# First time is first IBI.
		time << (ibi[0] /= 1000.0)
		# Loop from 2nd IBI to end.s
		for i in (1...ibi.length)
			# Time = cumulative sum of IBIs.
			time[i] = (ibi[i] /= 1000.0)+time[i-1]
		end
		return time, ibi
	end

	# Nearest neighbour interpolation.
	# Input parameters are two equal length arrays x and y, and a sampling rate. 
	# Array x does not need to be uniformly distributed.
	# Returns two equal length arrays x and y; x is uniformly distributed.
	def nni(x, y, r)
		# If x and y do not have equal length.
		if x.length != y.length
			return nil
		end

		# Nearest neighbour interpolation.
		inter_x = []						# array to store interpolated x
		inter_y = []						# array to store interpolated y
		i = 0
		p = x[0]						# pointer to current x, initialised to first x
		while i < x.length-1
			# If x[i] <= pointer <= x[i+1].
			if x[i] <= p && p <= x[i+1]
				delta_x = x[i+1]-x[i]
				delta_y = y[i+1]-y[i]
				gradient = delta_y/delta_x	# gradient
				# Add current pointer.
				inter_x << p
				# Add estimated y value for current pointer.
				inter_y << y[i]+(p-x[i])*gradient
				# Increment pointer.
				p += r
			elsif p > x[i+1]
				# Increment i.
				i += 1
			end
		end	
		return inter_x, inter_y
	end

	def get_min_hr
		return @@min_hr
	end

	def get_max_hr
		return @@max_hr
	end

	def get_power
		return @@power
	end

	def get_time
		return @@time
	end

	def get_mcf
		return @@mcf
	end

	def get_ttr
		return @@ttr
	end
end 
end
