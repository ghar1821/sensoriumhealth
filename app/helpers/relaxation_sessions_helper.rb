module RelaxationSessionsHelper
    # Sample class to generate FFT. No error corrections, no noise removal,
    # interpolation.
    def Sample
        # Define some arbitrary sample rate.
        @@sample_rate = 0.8
        # Define some arbitrary window size.
        @@window_size = 128
        
        def initialize(ibi)
            @ibi = ibi
        end
        
        # Fast Fourier Transform. Implementation is based of gregfjohnson.
        # Original code can be found at http://gregfjohnson.com/fftruby/
        # input.length is assumed to be a power of 2.
        # Returns -1 if error.
        def fft(input)
            # Check if input is a power of 2.
            if (Math.log(input.length)/Math.log(2)%1 != 0)
                return -1
            end
            
            # Base case.
            return input if input.length <= 1
            
            # split input into even and odd parts
            even = Array.new(input.length/2) { |i| input[2*i] }
            odd  = Array.new(input.length/2) { |i| input[2*i+1] }
            
            # Recursively solve each part.
            fft_even = fft(even)
            fft_odd  = fft(odd)
            
            # Double length of each part.
            fft_even.concat(fft_even)
            fft_odd.concat(fft_odd)
            
            # Calculate every element of FFT: e^(-2*pi*i*k/n).
            return Array.new(input.length) { |i| fft_even[i]+fft_odd[i]*Math::E**Complex(0, -2*Math::PI*i/input.length) }
        end
        
        # Converts complex numbers (x+yi) to magnitude. Defined by: sqrt(x^2+y^2).
        # Returns new vector of magnitudes of size N/2; second half of input vector
        # is imaginary and discared.
        def to_magnitude(input)
            magnitude = []
            for i in (0...input.length/2)
                magnitude << (input[i].magnitude)*i*@@sample_rate/@@window_size
            end
            return magnitude
        end
        
        # Returns magnitude.
        def get_magnitude
            return to_magnitude(fft(@ibi))
        end
    end
    
    #defines random data
    def get_data
		return [930.0004185,
        952.9996458,
        1000,
        1008.000161,
        1000,
        969.0000727,
        852.000426,
        952.9996458,
        991.9995238,
        1008.000161,
        991.9995238,
        930.0004185,
        969.0000727,
        976.9997965,
        984.0001574,
        914.000198,
        827.9996357,
        922.0003104,
        952.9996458,
        969.0000727,
        1000,
        937.999778,
        1008.000161,
        1016.000312,
        984.0001574,
        930.0004185,
        937.999778,
        984.0001574,
        984.0001574,
        952.9996458,
        914.000198,
        866.9994018,
        930.0004185,
        969.0000727,
        944.9994566,
        844.0005627,
        812.0002815,
        875.0003646,
        890.9995679,
        905.9995289,
        804.9995841,
        875.0003646,
        930.0004185,
        937.999778,
        930.0004185,
        875.0003646,
        875.0003646,
        890.9995679,
        827.9996357,
        757.9997398,
        757.9997398,
        804.9995841,
        827.9996357,
        789.000284,
        733.9997235,
        733.9997235,
        765.9998213,
        797.0000917,
        804.9995841,
        836.0004069,
        882.9996085,
        836.0004069,
        742.0003092,
        750,
        804.9995841,
        866.9994018,
        930.0004185,
        976.9997965,
        1008.000161,
        1016.000312,
        1000,
        1000,
        1008.000161,
        984.0001574,
        922.0003104,
        844.0005627,
        812.0002815,
        844.0005627,
        905.9995289,
        937.999778,
        952.9996458,
        984.0001574,
        1039.00062,
        1023.00046,
        1023.00046,
        1031.000466,
        1000,
        969.0000727,
        952.9996458,
        937.999778,
        930.0004185,
        937.999778,
        866.9994018,
        812.0002815,
        789.000284,
        797.0000917,
        804.9995841,
        827.9996357,
        866.9994018,
        898.0006017,
        930.0004185,
        960.9994394,
        1000,
        984.0001574,
        984.0001574,
        969.0000727,
        937.999778,
        944.9994566,
        905.9995289,
        844.0005627,
        812.0002815,
        812.0002815,
        827.9996357,
        858.9995233,
        898.0006017,
        944.9994566,
        1000,
        1000,
        991.9995238,
        976.9997965,
        914.000198,
        804.9995841,
        780.999836,
        742.0003092,
        695.0002838,
        727.0004326,
        757.9997398,
        727.0004326]		
	end
    
    # True if string is a valid float, else false.
	def is_float?
		Float(self) != nil rescue false
	end
    
end
