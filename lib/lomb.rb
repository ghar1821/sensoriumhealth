
# Performs Lomb analysis.
# Input parameters are two equal length arrays;
# the first is the time series, and the second is the value (ibi) series.
# Use "get" methods listed at the bottom.
module Lomb
	class << self
		# Global variables
		@@frequency			# Frequency bins (relative scale)
		@@amplitude			# Amplitude of each frequency bin

		# Initialise.
		def initialize(x, y)
			# Calculate all necessary information.
			fasper(x, y)
		end

		## ???
		def fasper (x, y)
			## Variables?
			## Assuming that each window has length = 128 exactly.
			l = 128
			## Originally 64*length = 2048
			n = 1024
			# Initialise arrays.
			@@frequency = Array.new(n, 0)
			@@amplitude = Array.new(n, 0)
			# Average and variance.
			avg, var = avg_var(y)
			# Minimum and maximum.
			min, max = min_max(x)
			## Difference multiplied by a scalar?
			diff = 4.0*(max-min).to_f
			## Variables?
			c1 = 0
			c2 = 0
			## ???
			for i in (0...l)
				## Variables?
				c1 = (x[i]-min).to_f*(n.to_f/diff)
				c1 %= n.to_f
				c2 = 2.0*c1
				c1 += 1.0
				c2 %= n.to_f
				c2 += 1.0
				## ???
				spread(c1, (y[i]-avg).to_f, @@frequency)
				spread(c2, 1.0, @@amplitude)
			end
			## ???
			realft(@@frequency)
			realft(@@amplitude)
			## Variables?
			i = 3-1
			j = 1
			## Originally 4*length
			while j <= l*2
				## Variables?
				hypo = Math.sqrt(@@amplitude[i]*@@amplitude[i]+@@amplitude[i+1]*@@amplitude[i+1])
				hc2wt = 0.5*@@amplitude[i]/hypo
				hs2wt = 0.5*@@amplitude[i+1]/hypo
				cwt = Math.sqrt(0.5+hc2wt)
				swt = sign(Math.sqrt(0.5-hc2wt), hs2wt)
				den = 0.5*l+hc2wt*@@amplitude[i]+hs2wt*@@amplitude[i+1]
				cterm = ((cwt*@@frequency[i]+swt*@@frequency[i+1])**2)/den
				sterm = ((cwt*@@frequency[i+1]-swt*@@frequency[i])**2)/(l-den)
				## ???
				@@frequency[j-1] = j*1.0/(diff)
				@@amplitude[j-1] = (cterm+sterm)/(2.0*var)
				## Increment index?
				i += 2
				j += 1
			end
		end

		## ???
		def spread(x, y, data)
			## ???
			if (x == x.to_i.to_f) 
				data[x.to_i-1] += y
			else 
				## Variables?
				ihi = (ilo = ([[x-1, 1].max, data.length-5].min).to_i)+3
				nden = 6.0
				fac = x-ilo
				## ???
				for i in (ilo+1..ihi)
					fac *= (x-i)
				end
				## ???
				data[ihi-1] += y*fac/(nden*(x-ihi))
				## ???
				for i in (ihi-1).downto(ilo)
					nden = (nden/(i+1-ilo).to_f)*(i-ihi).to_f
					data[i-1] += y*fac.to_f/(nden*(x-i)).to_f
				end
			end
		end

		## ???
		def realft(data)
			## Do Fourier transform?
			fourier(data)
			## Variables?
			theta = Math::PI/(data.length/2)
			wtemp = Math.sin(0.5*theta)
			wpreal = -2.0*wtemp*wtemp
			wpimag = Math.sin(theta)
			wreal = 1.0+wpreal
			wimag = wpimag
			## ???
			for i in (2..data.length/4)
				## Variables?
				i1 = 2*i-2
				i2 = i1+1
				i3 = data.length-i2+1
				i4 = i3+1
				## ???
				h1r = 0.5*(data[i1]+data[i3])
				h1i = 0.5*(data[i2]-data[i4])
				h2r = 0.5*(data[i2]+data[i4])
				h2i = -0.5*(data[i1]-data[i3])
				## ???
				data[i1] = h1r+wreal*h2r-wimag*h2i
				data[i2] = h1i+wreal*h2i+wimag*h2r
				data[i3] = h1r-wreal*h2r+wimag*h2i
				data[i4] = -h1i+wreal*h2i+wimag*h2r
				## Update variables?
				wreal = (wtemp = wreal)*wpreal-wimag*wpimag+wreal
				wimag = wimag*wpreal+wtemp*wpimag+wimag
			end

			data[0] = (h1r = data[0])+data[1]
			data[1] = h1r-data[1]
		end

		## Fast Fourier transform?
		def fourier(data)
			i = 0
			j = 0
			while i < data.length
				if j > i
					# Swap elements.
					data[j], data[i] = data[i], data[j]
					data[j+1], data[i+1] = data[i+1], data[j+1]
				end
				## Update index?
				m = data.length/2
				while m >= 2 && j+1 > m
					j -= m
					m /= 2
				end
				i += 2
				j += m
			end
			## ???
			k = 2
			while data.length > k
				## Variables?
				theta = Math::PI/k
				wtemp = Math.sin(theta)
				wpreal = -2.0*(wtemp**2)
				wpimag = Math.sin(2*theta)
				wreal = 1.0
				wimag = 0.0
				## ???
				for m in (1...k).step(2)
					for i in (m..data.length).step(k*2)
							## Reusing variable?
							j = i+k-1
							## ???
							tempr = wreal*data[j]-wimag*data[j+1]
							tempi = wreal*data[j+1]+wimag*data[j]
							## ???
							data[j] = data[i-1]-tempr
							data[j+1] = data[i]-tempi
							data[i-1] += tempr
							data[i] += tempi
					end
					# ???
					wreal = (wtemp = wreal)*wpreal-wimag*wpimag+wreal
					wimag = wimag*wpreal+wtemp*wpimag+wimag
				end
				## Update index?
				k *= 2
			end
			return data.clone
		end

		# Returns minimum and maximum values.
		def min_max(vector)
			return vector.minmax
		end

		# Returns average and variance of a vector.
		# var = sum((avg(vec)-vec[i])**2)/vec.length
		def avg_var(vector)
			# Calcualte average/
			sum = 0.0
			for i in (0...vector.length)
				sum += vector[i].to_f
			end
			average = sum/vector.length
			# Calculate variance.
			sq_sum = 0.0
			for i in (0...vector.length)
				sq_sum += (average-vector[i].to_f)**2
			end
			variance = sq_sum/(vector.length-1)
			return average, variance
		end

		# Returns |b| if a > 0; else -|b|.
		def sign(b, a)
			if a > 0
				return b.abs
			else
				return -1.0*(b.abs)
			end
		end

		# Input parameters are two equal length arrays x (frequency) and y (power).
		# Returns true if total LF power >= 50% total power.
		def is_resonant
			# Variables
			x = @@frequency
			y = @@amplitude
			# Constants
			vlf = [0.0033, 0.04]
			lf = [0.04, 0.15]
			hf = [0.15, 0.4]
			# Total sum of power in each frequency band
			total_vlf = 0.0
			total_lf = 0.0
			total_hf = 0.0
			for i in (0...x.length)
				if x[i] >= vlf[0] && x[i] <	vlf[1]
					total_vlf += y[i]
				elsif x[i] >= lf[0] && x[i] < lf[1]
					total_lf += y[i]
				elsif x[i] >= hf[0] && x[i] < hf[1]
					total_hf += y[i]
				elsif x[i] >= hf[1]
					break
				end
			end
			# Return true is LF > 50% of total.
			return total_lf >= 0.5*(total_vlf+total_lf+total_hf)
		end

		# Returns frequency and its corresponding power of the peak in LF band.
		def get_lf_peak
			# Variables
			x = @@frequency
			y = @@amplitude
			# Constants
			lf = [0.04, 0.15]
			# Maximum LF band frequency and power
			max_lf_x = 0.0
			max_lf_y = 0.0
			for i in (0...x.length)
				if x[i] >= lf[0] && x[i] < lf[1]
					if y[i] > max_lf_y
						max_lf_x = x[i]
						max_lf_y = y[i]
					end
				elsif x[i] >= lf[1]
					break
				end
			end
			return max_lf_x, max_lf_y
		end

		# Returns the percentage of LF band over the total.
		def get_lf_perc
			# Variables
			x = @@frequency
			y = @@amplitude
			# Constants
			vlf = [0.0033, 0.04]
			lf = [0.04, 0.15]
			hf = [0.15, 0.4]
			# Total sum of power in each frequency band
			total_vlf = 0.0
			total_lf = 0.0
			total_hf = 0.0
			for i in (0...x.length)
				if x[i] >= vlf[0] && x[i] <	vlf[1]
					total_vlf += y[i]
				elsif x[i] >= lf[0] && x[i] < lf[1]
					total_lf += y[i]
				elsif x[i] >= hf[0] && x[i] < hf[1]
					total_hf += y[i]
				elsif x[i] >= hf[1]
					break
				end
			end
			# Return percentage.
			return total_lf/(total_vlf+total_lf+total_hf)
		end

		def get_frequency
			return @@frequency
		end

		def get_amplitude
			return @@amplitude
		end
	end
end
