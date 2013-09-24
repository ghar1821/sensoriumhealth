module Fourier
    class << self
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
        @sample_rate = 0.8
        @window_size = 128
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

    # True if string is a valid float, else false.
    def is_float?
        Float(self) != nil rescue false
    end
end
